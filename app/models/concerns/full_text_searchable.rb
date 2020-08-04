# frozen_string_literal: true

module FullTextSearchable
  extend ActiveSupport::Concern

  class_methods do
    def ngrams(value, min: 2, max: 6)
      value = value.to_s
      [].tap do |result|
        (min..max).each do |num|
          result.concat value.scan(/\w{#{num}}/)
        end
      end.uniq
    end

    def fts_words(value)
      Loofah.fragment(value.to_s).scrub!(:whitewash).to_text.gsub(/\W/, " ").squeeze(" ").downcase.split
    end

    def fts_string(value)
      value = fts_words(value).join(" ")
      value = value.chop while value.bytes.size > 2046
      value
    end
  end

  delegate :ngrams, :fts_words, :fts_string, to: "self.class"

  included do
    has_one :full_text_search, as: :record
    before_destroy :destroy_full_text_search
  end

  delegate :ngrams, to: "self.class"

  def update_full_text_search
    tsvectors = to_tsvectors.compact.uniq
    return if tsvectors.blank?
    tsvectors.pop while tsvectors.size > 500
    tsvectors.concat similarity_words_tsvectors
    tsvector = tsvectors.join(" || ")
    fts = FullTextSearch.where(record: self).first_or_create
    fts.update_value tsvector
  end

  # ApplicationRecord::FullTextSearchable#to_tsvectors is abstract... a noop by default
  # it must be implemented in including ActiveRecord models if this behavior is desired
  def to_tsvectors
    []
  end

  def similarity_words
    tsvectors = to_tsvectors.compact.uniq
    return [] if tsvectors.blank?
    tsvector = tsvectors.join(" || ")

    ts_stat = Arel::Nodes::NamedFunction.new("ts_stat", [
      Arel::Nodes::SqlLiteral.new(sanitize_sql_value("SELECT #{tsvector}"))
    ])
    length = Arel::Nodes::NamedFunction.new("length", [Arel::Nodes::SqlLiteral.new(quote_column_name(:word))])
    query = self.class.select(:word).from(ts_stat.to_sql).where(length.gteq(3)).to_sql
    result = self.class.connection.execute(query)
    result.values.flatten
  end

  def similarity_words_tsvectors(weight: "C")
    similarity_words.each_with_object([]) { |word, memo|
      ngrams(word).each { |ngram| memo << make_tsvector(ngram, weight: weight) }
    }.compact.uniq
  end

  protected

  def make_tsvector(value, weight: "D")
    value = fts_string(value).gsub(/\W/, " ").squeeze.downcase
    return nil if value.blank?
    to_tsv = Arel::Nodes::NamedFunction.new("to_tsvector", [
      Arel::Nodes::SqlLiteral.new("'english'"),
      Arel::Nodes::SqlLiteral.new(sanitize_sql_value(value))
    ])
    setweight = Arel::Nodes::NamedFunction.new("setweight", [
      to_tsv,
      Arel::Nodes::SqlLiteral.new(sanitize_sql_value(weight))
    ])
    setweight.to_sql
  end

  private

  def destroy_full_text_search
    full_text_search&.destroy
  end
end

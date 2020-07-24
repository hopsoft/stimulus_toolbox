# == Schema Information
#
# Table name: full_text_searches
#
#  id          :bigint           not null, primary key
#  record_type :string           not null
#  value       :tsvector
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  record_id   :integer          not null
#
# Indexes
#
#  index_full_text_searches_on_record_type_and_record_id  (record_type,record_id) UNIQUE
#  index_full_text_searches_on_value                      (value) USING gin
#
class FullTextSearch < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :record, polymorphic: true, dependent: :delete

  # validations ...............................................................
  # callbacks .................................................................

  # scopes ....................................................................
  scope :matched, ->(value) {
    value = value.to_s.gsub(/\W/, " ").squeeze(" ").downcase.strip
    value.blank? ? all : begin
      value = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["?", value]))
      plainto_tsquery = Arel::Nodes::NamedFunction.new("plainto_tsquery", [Arel::Nodes::SqlLiteral.new("'english'"), value])
      where Arel::Nodes::InfixOperation.new("@@", arel_table[:value], plainto_tsquery)
    end
  }

  scope :ranked, ->(value) {
    rank_alias = "rank_#{SecureRandom.hex}"
    value = value.to_s.gsub(/\W/, " ").squeeze(" ").downcase.strip
    value.blank? ? all : begin
      value = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["?", value]))
      plainto_tsquery = Arel::Nodes::NamedFunction.new("plainto_tsquery", [Arel::Nodes::SqlLiteral.new("'english'"), value])
      ts_rank = Arel::Nodes::NamedFunction.new("ts_rank", [arel_table[:value], plainto_tsquery])
      select(Arel.star)
        .select(ts_rank.as(rank_alias))
        .order("#{rank_alias} desc")
    end
  }

  scope :matched_and_ranked, ->(value) { value.blank? ? all : matched(value).ranked(value) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def update_value(tsvector_sql)
    sql = <<~SQL
      UPDATE full_text_searches
      SET value = (#{tsvector_sql})
      WHERE record_type = :record_type
      AND record_id = :record_id;
    SQL
    self.class.connection.execute self.class.sanitize_sql_array([
      sql,
      value: tsvector_sql,
      record_type: record_type,
      record_id: record_id
    ])
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id                     :bigint           not null, primary key
#  approved               :boolean          default(FALSE), not null
#  description            :text             not null
#  github_data            :jsonb            not null
#  github_name            :text
#  github_synchronized_at :datetime
#  github_url             :text
#  name                   :text             not null
#  npm_data               :jsonb            not null
#  npm_name               :text
#  npm_synchronized_at    :datetime
#  npm_url                :text
#  tags                   :text             default([]), not null, is an Array
#  url                    :text             not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_projects_on_approved          (approved)
#  index_projects_on_lower_btrim_name  (lower(btrim(name))) UNIQUE
#  index_projects_on_tags              (tags) USING gin
#  index_projects_on_url               (url) UNIQUE
#
class Project < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include FullTextSearchable
  include Githubable
  include Npmable

  # relationships .............................................................

  # validations ...............................................................
  validates :name, uniqueness: {case_sensitive: false}, length: {minimum: 3}
  validates :description, length: {minimum: 36}
  validates :github_name, format: {with: /\A([^\/]+\/[^\/]+)(?!=\/)\z/}, length: {minimum: 3}, allow_blank: true
  validates :npm_name, length: {minimum: 1}, allow_blank: true
  validates :url, url: true, uniqueness: true, presence: true
  validates :github_url, url: true, format: {with: /\Ahttps:\/\/github\.com\/[^\/]+\/[^\/]+/}, allow_blank: true
  validates :npm_url, url: true, format: {with: /\Ahttps:\/\/www\.npmjs\.com\/package\/.+/}, allow_blank: true

  # callbacks .................................................................
  after_save -> { defer.update_full_text_search }, if: :approved?

  # scopes ....................................................................
  scope :approved, -> { where approved: true }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................
  def to_tsvectors
    []
      .then { |result| result << make_tsvector(name, weight: "A") }
      .then { |result| result << make_tsvector(github_name, weight: "A") }
      .then { |result| result << make_tsvector(npm_name, weight: "A") }
      .then { |result| tags.each_with_object(result) { |tag, memo| memo << make_tsvector(tag, weight: "B") } }
      .then { |result| result << make_tsvector(description, weight: "C") }
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end

# == Schema Information
#
# Table name: projects
#
#  id                    :bigint           not null, primary key
#  description           :text
#  github_data           :jsonb            not null
#  github_name           :text
#  github_sychronized_at :datetime
#  github_url            :text
#  human_name            :text             not null
#  license_name          :text
#  license_url           :text
#  npm_data              :jsonb            not null
#  npm_name              :text
#  npm_sychronized_at    :datetime
#  npm_url               :text
#  tags                  :text             default([]), not null, is an Array
#  url                   :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_projects_on_github_name  (github_name) UNIQUE
#  index_projects_on_github_url   (github_url) UNIQUE
#  index_projects_on_human_name   (human_name) UNIQUE
#  index_projects_on_npm_name     (npm_name) UNIQUE
#  index_projects_on_npm_url      (npm_url) UNIQUE
#  index_projects_on_tags         (tags) USING gin
#  index_projects_on_url          (url) UNIQUE
#
class Project < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include FullTextSearchable
  include Githubable
  include Npmable

  # relationships .............................................................

  # validations ...............................................................
  validates :human_name, uniqueness: true, length: {minimum: 3}
  validates :github_name, uniqueness: true, length: {minimum: 3}, allow_blank: true
  validates :npm_name, uniqueness: true, length: {minimum: 3}, allow_blank: true
  validates :url, url: true, uniqueness: true, allow_blank: true
  validates :github_url, url: true, uniqueness: true, allow_blank: true
  validates :npm_url, url: true, uniqueness: true, allow_blank: true

  # callbacks .................................................................

  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................
  def to_tsvectors
    []
      .then { |result| result << make_tsvector(human_name, weight: "A") }
      .then { |result| result << make_tsvector(github_name, weight: "A") }
      .then { |result| result << make_tsvector(npm_name, weight: "A") }
      .then { |result| tags.each_with_object(result) { |tag, memo| memo << make_tsvector(tag, weight: "B") } }
      .then { |result| result << make_tsvector(description, weight: "C") }
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end

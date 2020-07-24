# == Schema Information
#
# Table name: projects
#
#  id                :bigint           not null, primary key
#  archived          :boolean          default(FALSE), not null
#  description       :text
#  disabled          :boolean          default(FALSE), not null
#  forks_count       :integer          default(0), not null
#  license_name      :text
#  license_url       :text
#  name              :text             not null
#  open_issues_count :integer          default(0), not null
#  repo_url          :text             not null
#  stars_count       :integer          default(0), not null
#  subscribers_count :integer          default(0), not null
#  tags              :text             default([]), not null, is an Array
#  url               :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_projects_on_name  (name)
#  index_projects_on_tags  (tags) USING gin
#
class Project < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include FullTextSearchable

  # relationships .............................................................

  # validations ...............................................................
  validates :name, length: {minimum: 3}
  validates :url, url: true
  validates :repo_url, url: true

  # callbacks .................................................................

  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................
  def to_tsvectors
    []
      .then { |result| result << make_tsvector(name, weight: "A") }
      .then { |result| tags.each_with_object(result) { |tag, memo| memo << make_tsvector(tag, weight: "B") } }
      .then { |result| result << make_tsvector(description, weight: "C") }
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end

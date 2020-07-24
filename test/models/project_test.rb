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
require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

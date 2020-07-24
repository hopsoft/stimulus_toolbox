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
require "test_helper"

class FullTextSearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

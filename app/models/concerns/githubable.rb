module Githubable
  extend ActiveSupport::Concern

  included do
    after_save -> { update_github_data }
  end

  private

  def upate_github_data
    if sychronized_at.nil? || sychronized_at.advance(weeks: 1) <= Time.current
      binding.pry
    end
  end
end

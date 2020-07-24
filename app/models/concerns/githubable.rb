module Githubable
  extend ActiveSupport::Concern

  included do
    after_save -> { defer.update_github_data }
  end

  def update_github_data
    return unless github_name.present?
    return if github_sychronized_at.try(:advance, weeks: 1)&.after?(Time.current)

    client ||= Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
    repo = client.repo(github_name)
    update_columns github_data: repo.to_h, github_sychronized_at: Time.current
  end
end

# frozen_string_literal: true

module Githubable
  extend ActiveSupport::Concern

  included do
    after_save -> { defer.update_github_data! }
  end

  def update_github_data!
    return unless github_name.present?
    return if github_synchronized_at.try(:advance, weeks: 1)&.after?(Time.current)

    client ||= Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
    repo = client.repo(github_name)
    update_columns github_data: repo.to_h, github_synchronized_at: Time.current
  end

  def github_project
    @github_project ||= GithubProject.new(github_data)
  end
end

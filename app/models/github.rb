class Github
  class << self
    # Returns an Octokit GitHub API client instance
    def client
      @client ||= Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
    end

    # Returns a Sawyer::Resource representation of a GitHub repo
    #
    # @param repo [String] the short name for the GitHub repo i.e. "hopsoft/stimulus_toolbox"
    def repo(repo)
      Rails.temporary_cache.fetch(repo) { client.repo repo }
    end

    # Returns a Sawyer::Resource representation of a GitHub repo
    #
    # @param repo [String] the short name for the GitHub repo i.e. "hopsoft/stimulus_toolbox"
    def issues(repo)
      Rails.temporary_cache.fetch(repo) { client.list_issues repo }
    end
  end
end

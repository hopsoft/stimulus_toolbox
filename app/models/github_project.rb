class GithubProject
  attr_reader :data

  def initialize(github_data = {})
    @data = github_data
  end

  def owner_name
    data.dig("owner", "login")
  end

  def owner_url
    data.dig("owner", "html_url")
  end

  def owner_avatar_url
    data.dig("owner", "avatar_url")
  end

  def description
    data["description"]
  end

  def url
    data["html_url"]
  end

  def homepage_url
    data["homepage"]
  end

  def license_name
    data.dig("license", "name")
  end

  def license_url
    data.dig("license", "url")
  end

  def forks_count
    data["forks_count"].to_i
  end

  def open_issues_count
    data["open_issues_count"].to_i
  end

  def watchers_count
    data["watchers_count"].to_i
  end

  alias stars_count watchers_count

  def subscribers_count
    data["subscribers_count"].to_i
  end

  def fork?
    !!data["fork"]
  end

  def archived?
    !!data["archived"]
  end

  def disabled?
    !!data["disabled"]
  end
end

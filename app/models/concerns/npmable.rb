# frozen_string_literal: true

module Npmable
  extend ActiveSupport::Concern

  included do
    after_save -> { defer.update_npm_data! }
  end

  def update_npm_data!
    return unless npm_name.present?
    return if npm_synchronized_at.try(:advance, weeks: 1)&.after?(Time.current)

    domain = "api.npmjs.org"
    path = "/downloads/range/#{12.months.ago.to_date.iso8601}:#{Date.current.iso8601}/#{npm_name}"

    net = Net::HTTP.new(domain, 443)
    net.use_ssl = true
    response = net.get(path)
    update_columns npm_data: JSON.parse(response.body), npm_synchronized_at: Time.current if response.code.to_s == "200"
  end

  def npm_project
    @npm_project ||= NpmProject.new(npm_data)
  end
end

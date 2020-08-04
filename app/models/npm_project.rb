# frozen_string_literal: true

class NpmProject
  attr_reader :data

  def initialize(npm_data = {})
    @data = npm_data
  end

  def downloads_by_day
    @downloads_by_day ||= (data["downloads"] || {}).each_with_object({}) { |entry, memo|
      memo[Date.parse(entry["day"])] = entry["downloads"]
    }
  end

  def cumulative_downloads_by_day
    total_downloads = 0
    downloads_by_day.each_with_object({}) do |(date, downloads), memo|
      memo[date] = total_downloads += downloads
    end
  end

  def downloads_by_week
    weekly_downloads = 0
    last_date = downloads_by_day.keys.last
    downloads_by_day.each_with_object({}) do |(date, downloads), memo|
      weekly_downloads = 0 if date.sunday?
      weekly_downloads += downloads
      memo[date.beginning_of_week] = weekly_downloads if date.saturday? || date == last_date
    end
  end

  def cumulative_downloads_by_week
    total_downloads = 0
    downloads_by_week.each_with_object({}) do |(date, downloads), memo|
      memo[date] = total_downloads += downloads
    end
  end

  def downloads_count
    downloads_by_day.values.sum
  end
end

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.6"

gem "bootsnap", ">= 1.4.2", require: false
gem "hiredis", "~> 0.6.3", require: %w[redis redis/connection/hiredis]
gem "jbuilder", "~> 2.7"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.2"
gem "redis", "~> 4.0"
gem "sass-rails", ">= 6"
gem "sidekiq", "~> 6.1"
gem "stimulus_reflex", "~> 3.3.0.pre2"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.1"

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv"
end

group :development do
  gem "listen", "~> 3.2"
  gem "model_probe"
  gem "standardrb"
  gem "tmuxinator"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

gem "rails", "7.2.0.beta3"
gem "propshaft"
gem "pg"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:windows, :jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "thruster"
gem "solid_cache"
gem "solid_queue"
gem "mobility"
gem "pghero"
gem "mission_control-jobs"
gem "view_component"
gem "pry-rails"
gem "devise"
# gem "devise-two-factor", ">= 5.0.0"
gem "devise-i18n"
gem "devise_zxcvbn"
gem "graphql"
gem "graphiql-rails"
gem "prosopite"
gem "pg_search"
gem "rails-html-sanitizer"
gem "pg_query"

gem "sshkit", require: false
gem "uri", ">= 0.12.2"

group :production do
  gem "rack-timeout"
end

group :development, :test do
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false
  gem "lookbook"
  gem "dotenv-rails"
  gem "rspec-rails", ">= 6.0.1"
  gem "factory_bot_rails"
  gem "faker"
  # gem "sql_tracker"
  gem "rubocop", require: false
  gem "rubocop-disable_syntax", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-graphql", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "rubocop-factory_bot", require: false
  gem "standard", "1.39.2", require: false
  # gem "squasher", require: false
  gem "fasterer", require: false
  gem "license_finder", require: false
  # gem "better_html", require: false
  # gem "erb_lint", require: false
end

group :development do
  gem "foreman", require: false
  # gem "active_record_doctor"
  # gem "cacheflow"
  # gem "gemdiff", require: false
  # gem "graphql-rails_logger"
  gem "bundler-audit", require: false
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "rails-controller-testing"
  gem "shoulda-matchers"
  gem "rspec-its"
  # gem "super_diff"
  # gem "simplecov"
  # gem "simplecov-cobertura", require: false
  gem "database_rewinder"
  # gem "webmock"
  # gem "vcr"
end

# gem "httplog"

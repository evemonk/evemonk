# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

gem "rails", "8.1.1"

gem "propshaft"
gem "pg"
gem "puma"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "dartsass-rails"
gem "jbuilder"

gem "tzinfo-data", platforms: [:windows, :jruby]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false

gem "thruster"
gem "view_component"
gem "inline_svg"
gem "good_migrations"
gem "local_time"
gem "rails-i18n"
gem "http_accept_language"
gem "devise"
gem "devise-two-factor", ">= 5.0.0"
gem "devise-i18n"
gem "devise_zxcvbn"
gem "rqrcode"
gem "graphql"
gem "graphiql-rails"
gem "rack-cors"
gem "pg_search"
gem "meta-tags"
gem "rufus-scheduler"
gem "eve_online",
  git: "https://github.com/evemonk/eve_online.git",
  branch: "updates"
gem "omniauth-eve_online-sso"
gem "omniauth-rails_csrf_protection"
gem "jwt"
gem "ancestry"
gem "kaminari"
gem "kaminari-i18n"
gem "rails-html-sanitizer"
gem "mobility"
gem "pundit"
gem "rails-settings-cached"
gem "net-http-persistent"
gem "connection_pool"
gem "redis"
gem "mission_control-jobs"
gem "pghero"
gem "pg_query"
gem "ruby-pg-extras"
gem "rails-pg-extras"
gem "noticed"
gem "responders"
gem "aws-sdk-s3"
gem "down"
gem "sitemap_generator"
gem "administrate"
gem "pry-rails"
gem "skylight"
gem "lograge"
gem "prosopite"
gem "sshkit", require: false
gem "maintenance_tasks"
gem "rails_pulse"

gem "airbrake", "~> 13.0"

group :production do
  gem "rack-timeout"
end

group :development, :test do
  gem "lookbook"
  gem "rspec-rails", ">= 6.0.1", require: false
  gem "rspec-retry", require: false
  gem "factory_bot_rails"
  gem "faker"
  gem "rubocop", require: false
  gem "rubocop-disable_syntax", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-graphql", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "rubocop-factory_bot", require: false
  gem "standard", "1.51.1", require: false
  gem "squasher", require: false
  gem "brakeman", require: false
  gem "fasterer", require: false
  gem "license_finder", require: false
  gem "herb", require: false
end

group :development do
  gem "foreman", require: false
  gem "active_record_doctor"
  gem "cacheflow"
  gem "gemdiff", require: false
  gem "graphql-rails_logger"
  gem "bundler-audit", require: false
end

group :test do
  gem "capybara", ">= 3.26"
  gem "pundit-matchers"
  gem "selenium-webdriver"
  gem "rails-controller-testing"
  gem "shoulda-matchers"
  gem "rspec-its"
  gem "super_diff"
  gem "simplecov"
  gem "simplecov-cobertura", require: false
  gem "database_rewinder"
  gem "webmock"
  gem "vcr"
end

gem "httplog"
# Also please contact the author of httplog-1.7.3 to request adding benchmark into its gemspec.
gem "benchmark"

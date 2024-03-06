# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

gem "rails", git: "https://github.com/rails/rails.git", branch: "7-1-stable"

gem "sprockets-rails"
gem "pg"
gem "puma"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: [:windows, :jruby]
gem "bootsnap", require: false
gem "solid_cache"
gem "solid_queue"
gem "mission_control-jobs"

gem "dartsass-rails"
gem "view_component"
gem "solid_errors"
gem "flipper"
gem "flipper-active_record"
gem "flipper-ui"
gem "inline_svg"
gem "bootstrap", "5.2.3"
gem "bootswatch",
  git: "https://github.com/thomaspark/bootswatch.git",
  tag: "v5.2.3"
gem "good_migrations"
gem "local_time"
gem "rails-i18n", "~> 7.0.9"
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
gem "eve_online"
gem "omniauth-eve_online-sso"
gem "omniauth-rails_csrf_protection"
gem "jwt"
gem "ancestry"
gem "faraday-http-cache"
gem "kaminari"
gem "kaminari-i18n"
gem "rails-html-sanitizer"
gem "mobility"
gem "pundit"
gem "rails-settings-cached"
gem "net-http-persistent"
gem "connection_pool"
gem "redis"
gem "pghero"
gem "pg_query"
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
gem "uri", ">= 0.12.2"

group :production do
  gem "rack-timeout"
end

group :development, :test do
  gem "lookbook"
  gem "dotenv-rails"
  gem "rspec-rails", ">= 6.0.1"
  gem "factory_bot_rails"
  gem "faker"
  gem "sql_tracker"
  gem "rubocop", require: false
  gem "rubocop-disable_syntax", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-graphql", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-capybara", require: false
  gem "standard", "1.35.1", require: false
  gem "squasher", require: false
  gem "brakeman", require: false
  gem "fasterer", require: false
  gem "license_finder", require: false
  gem "better_html", require: false
  gem "erb_lint", require: false
end

group :development do
  gem "foreman", require: false
  gem "active_record_doctor"
  gem "cacheflow"
  gem "gemdiff", require: false
  gem "derailed_benchmarks"
  gem "graphql-rails_logger"
  gem "bundler-audit", require: false
end

group :test do
  gem "capybara", ">= 3.26"
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

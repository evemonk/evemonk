# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version")

gem "rails", "7.0.3"

gem "pg", "~> 1.3"
gem "puma", "~> 5.6"
gem "importmap-rails", ">= 0.3.4"
gem "turbo-rails", ">= 0.7.4"
gem "stimulus-rails", ">= 0.3.9"
gem "jbuilder", "~> 2.11"
gem "sassc-rails", "~> 2.1"
gem "bootsnap", ">= 1.4.4", require: false
gem "bootstrap", "4.6.1"
gem "bootswatch",
  git: "https://github.com/thomaspark/bootswatch.git",
  branch: "v4.6.1"
gem "good_migrations"
gem "local_time"
gem "rails-i18n", "~> 7.0.3"
gem "http_accept_language"
gem "countries"
gem "oj"
gem "authy"
gem "devise"
gem "devise-i18n"
gem "devise_zxcvbn"
gem "devise-authy"
gem "graphql"
gem "graphiql-rails"
gem "pg_search"
gem "meta-tags",
  git: "https://github.com/kpumuk/meta-tags.git",
  branch: "main"
gem "metricky"
gem "dalli"
gem "foundation_emails"
gem "rufus-scheduler"
gem "eve_online"
gem "omniauth-eve_online-sso"
gem "omniauth-rails_csrf_protection"
gem "jwt"
gem "kaminari"
gem "kaminari-i18n"
gem "rails-html-sanitizer"
gem "mobility"
gem "pundit"
gem "paper_trail"
gem "rails-settings-cached"
gem "net-http-persistent"
gem "connection_pool"
gem "sidekiq", require: false
gem "pghero"
gem "pg_query"
gem "noticed"
# gem "rubycritic", require: false
gem "responders"
gem "rack-health"
gem "aws-sdk-s3"
gem "down"
gem "sitemap_generator"
gem "administrate"
gem "sentry-ruby"
gem "sentry-rails"
gem "sentry-sidekiq"
gem "server_timing"
gem "awesome_print", require: "ap"
gem "pry-rails"
gem "skylight"
gem "lograge"
gem "webrick"
gem "maintenance_tasks"
gem "yabeda-prometheus"
gem "yabeda-rails"
gem "yabeda-graphql"
gem "yabeda-sidekiq"
gem "yabeda-puma-plugin"
# gem "yabeda-gc"
# gem "console_creep"

# gem "oink"

group :production do
  # gem "newrelic_rpm"
  gem "rack-timeout"
end

group :development, :test do
  gem "dotenv-rails"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "sql_tracker"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-graphql", require: false
  gem "standard", require: false
  gem "squasher", require: false
  gem "brakeman", require: false
  gem "fasterer", require: false
  gem "license_finder", require: false
  gem "anyway_config" # For isolator
  gem "isolator"
  gem "erb_lint", require: false
end

group :development do
  # Display speed badge on every html page with SQL times and flame graphs.
  # Note: Interferes with etag cache testing. Can be configured to work on production: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem "rack-mini-profiler", "~> 2.0"
  gem "consistency_fail", require: false
  gem "active_record_doctor"
  gem "cacheflow"
  gem "gemdiff", require: false
  gem "derailed_benchmarks"
  gem "graphql-rails_logger"
  gem "prosopite"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
  gem "rails-controller-testing"
  gem "shoulda-matchers"
  gem "rspec-its"
  gem "super_diff"
  # gem "rspec-stubbed_env"
  gem "shoulda-callback-matchers",
    git: "https://github.com/just806me/shoulda-callback-matchers.git",
    branch: "master"
  gem "simplecov"
  gem "database_rewinder"
  gem "webmock"
  gem "vcr"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "httplog"

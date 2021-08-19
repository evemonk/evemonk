# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version")

gem "rails", "6.1.4"
gem "pg", "~> 1.1"
gem "puma", "~> 5.4"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.4"
gem "turbo-rails"
gem "jbuilder", "~> 2.11"
gem "bootsnap", ">= 1.4.4", require: false
gem "local_time"
gem "rails-i18n", "~> 6.0.0"
gem "http_accept_language"
gem "countries"
gem "oj"
gem "tzinfo-data"
gem "authy"
gem "devise"
gem "devise-i18n"
# Until next release. https://github.com/bitzesty/devise_zxcvbn/pull/40
gem "devise_zxcvbn", git: "https://github.com/bitzesty/devise_zxcvbn.git", branch: "master"
gem "devise-authy"
gem "rack-floc-off"
gem "ar_lazy_preload"
gem "graphql"
gem "graphiql-rails"
gem "pg_search"
gem "meta-tags"
gem "rails-pg-extras"
gem "metricky"
gem "dalli"
gem "foundation_emails"
gem "rufus-scheduler"
gem "eve_online"
gem "omniauth-eve_online-sso"
gem "omniauth-rails_csrf_protection"
gem "jwt"
gem "rack-cors", require: "rack/cors"
gem "kaminari"
gem "kaminari-i18n"
gem "rails-html-sanitizer"
gem "mobility"
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
gem "sitemap_generator"
gem "typhoeus"
gem "administrate"
gem "sentry-ruby"
gem "sentry-rails"
gem "sentry-sidekiq"
gem "niceql"
gem "server_timing"
gem "easymon"
gem "awesome_print", require: "ap"
gem "pry-rails"
gem "lograge"
gem "webrick"
gem "yabeda-prometheus"
gem "yabeda-rails"
gem "yabeda-graphql"
gem "yabeda-sidekiq"
gem "yabeda-puma-plugin"
# gem "yabeda-gc"
# gem "console_creep"

# gem "oink"

group :production do
  gem "newrelic_rpm"
  gem "rack-timeout"
end

group :development, :test do
  gem "dotenv-rails"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "sql_tracker"
  gem "bundler-audit", require: false
  gem "rubocop", require: false
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
  gem "listen", "~> 3.7"
  gem "consistency_fail", require: false
  gem "active_record_doctor"
  gem "cacheflow"
  gem "gemdiff", require: false
  gem "derailed_benchmarks"
  gem "graphql-rails_logger"
  gem "prosopite"
end

group :test do
  gem "codecov", require: false
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
  gem "rails-controller-testing"
  gem "shoulda-matchers"
  gem "rspec-its"
  gem "super_diff"
  # gem "rspec-stubbed_env"
  gem "shoulda-callback-matchers", git: "https://github.com/just806me/shoulda-callback-matchers.git",
                                   branch: "master"
  gem "simplecov"
  gem "database_rewinder"
  gem "webmock"
  gem "vcr"
end

gem "httplog"

# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "6.0.3.3"
gem "pg", ">= 0.18", "< 2.0"
gem "puma"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "rails-i18n", "~> 6.0.0"
gem "http_accept_language"
gem "countries"
gem "authy"
gem "devise"
gem "devise-i18n"
gem "devise_zxcvbn"
gem "devise-authy"
gem "ar_lazy_preload"
gem "graphql"
gem "graphiql-rails"
gem "cable_ready"
gem "stimulus_reflex"
gem "meta-tags"
gem "rails-pg-extras"
gem "metricky"
gem "dalli"
gem "foundation_emails"
gem "rufus-scheduler"
gem "eve_online"
# gem "eve_online", git: "https://github.com/evemonk/eve_online.git", branch: "dev"
gem "omniauth-eve_online-sso"
gem "omniauth-rails_csrf_protection"
gem "jwt"
gem "rack-cors", require: "rack/cors"
gem "kaminari"
gem "kaminari-i18n"
gem "rails-html-sanitizer"
gem "draper"
gem "mobility"
gem "paper_trail"
gem "rails-settings-cached"
gem "net-http-persistent"
gem "connection_pool"
gem "sidekiq", require: false
gem "rpush"
gem "pghero"
gem "pg_query"
# gem "rubycritic", require: false
gem "swagger-blocks"
gem "responders"
gem "rack-health"
gem "sitemap_generator"
gem "searchkick"
gem "typhoeus"
gem "administrate"
gem "sentry-raven"
gem "errbase"
gem "activerecord-nulldb-adapter"
gem "niceql"
gem "server_timing"
# gem "traceroute"
# gem "strong_migrations"
gem "easymon"
gem "good_migrations"
# gem "elastic-apm"

gem "awesome_print", require: "ap"
gem "pry-rails"

gem "lograge"

gem "yabeda-prometheus"
gem "yabeda-rails"
gem "yabeda-sidekiq"
gem "yabeda-puma-plugin"

# gem "oink"

group :production do
  gem "newrelic_rpm"
  gem "rack-timeout"
end

group :development, :test do
  gem "dotenv-rails"
  gem "rspec-rails"
  gem "bullet"
  gem "factory_bot_rails"
  gem "faker"
  gem "faker-bot", require: false
  gem "sql_tracker"
  gem "bundler-audit", require: false
  gem "bundler-leak", require: false
  gem "rubocop", require: false
  gem "standard", require: false
  gem "squasher", require: false
  gem "mdl", require: false
  gem "brakeman", require: false
  gem "fasterer", require: false
  gem "license_finder", require: false
  gem "anyway_config" # For isolator
  gem "isolator"
  gem "erb_lint", require: false
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "spring-commands-rspec", require: false
  gem "spring-commands-rubocop", require: false
  gem "spring-commands-standard", require: false
  gem "consistency_fail", require: false
  gem "rails_best_practices"
  gem "active_record_doctor"
  # gem "overcommit", require: false
  gem "cacheflow"
  gem "gemdiff", require: false
  gem "derailed_benchmarks"
  gem "graphql-rails_logger"
end

group :test do
  gem "codecov", require: false
  gem "capybara", ">= 2.15"
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

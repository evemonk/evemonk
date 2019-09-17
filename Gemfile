# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "6.0.0"
gem "pg", ">= 0.18", "< 2.0"
gem "puma"
gem "sass-rails"
gem "webpacker", "~> 4.0"
gem "jbuilder", "~> 2.7"
gem "devise"
gem "omniauth-rails_csrf_protection"
gem "bootsnap", ">= 1.4.2", require: false
gem "meta-tags"
gem "metricky"
gem "dalli"
gem "foundation_emails"
# gem "rufus-scheduler"
gem "bcrypt"
# gem "eve_online"
gem "eve_online", git: "https://github.com/evemonk/eve_online.git", branch: "master"
# gem "eve_online", git: "https://github.com/evemonk/eve_online.git", branch: "dev"
# gem "eve_online", path: "~/opensource/eve_online"
gem "omniauth-eve_online-sso"
gem "jwt"
gem "rack-cors", require: "rack/cors"
gem "kaminari"
gem "rails-html-sanitizer"
gem "pundit"
gem "draper"
gem "mobility"
gem "paper_trail"
gem "rails-settings-cached"
gem "sidekiq", require: false
gem "sidekiq-scheduler", require: false
gem "rpush"
gem "pghero"
gem "pg_query"
# gem "rubycritic", require: false
gem "swagger-blocks"
gem "http_logger"
gem "responders"
gem "rack-health"
gem "sitemap_generator"
gem "rotp"
gem "searchkick"
gem "sentry-raven"
gem "errbase"
gem "activerecord-nulldb-adapter"
gem "niceql"
gem "server_timing"
gem "strong_migrations"

gem "awesome_print", require: "ap"
gem "pry-rails"

# gem "act-fluent-logger-rails", git: "https://github.com/actindi/act-fluent-logger-rails.git",
#                                branch: "master"

gem "lograge"

gem "prometheus-client"
gem "yabeda-prometheus"
gem "yabeda-rails"
gem "yabeda-sidekiq"
gem "yabeda-puma-plugin"

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveStorage variant
# gem 'image_processing', '~> 1.2'

group :production do
  gem "newrelic_rpm"
  gem "rack-timeout"
end

group :development, :test do
  gem "dotenv-rails"
  gem "rspec-rails", "4.0.0.beta2"
  ["rspec-core", "rspec-expectations", "rspec-mocks", "rspec-support"].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: "master"
  end
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
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "spring-commands-rspec", require: false
  gem "spring-commands-rubocop", require: false
  gem "consistency_fail", require: false
  gem "rails_best_practices"
  gem "active_record_doctor"
  # gem 'overcommit', require: false
  gem "cacheflow"
  gem "gemdiff", require: false
  gem "derailed_benchmarks"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
  gem "rails-controller-testing"
  # https://github.com/thoughtbot/shoulda-matchers/pull/1237
  gem "shoulda-matchers", git: "https://github.com/thoughtbot/shoulda-matchers.git",
                          branch: "master"
  gem "rspec-its"
  gem "shoulda-callback-matchers", git: "https://github.com/just806me/shoulda-callback-matchers.git",
                                   branch: "master"
  gem "simplecov"
  gem "database_rewinder"
  gem "webmock"
  gem "vcr"
end

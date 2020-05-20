# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "~> 6.0.3", ">= 6.0.3.1"
gem "pg", ">= 0.18", "< 2.0"
gem "puma"
gem "sass-rails", ">= 6.0.0"
gem "webpacker", "~> 4.2", ">= 4.2.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.10", ">= 2.10.0"
gem "bootsnap", ">= 1.4.2", require: false
gem "rails-i18n", "~> 6.0.0"
gem "http_accept_language"
gem "countries"
gem "authy"
gem "devise", ">= 4.7.1"
gem "devise-i18n", ">= 1.9.1"
gem "devise_zxcvbn", ">= 5.1.0"
gem "devise-authy", ">= 2.1.0"
gem "stimulus_reflex", ">= 3.2.1"
gem "meta-tags", ">= 2.13.0"
gem "rails-pg-extras", ">= 1.1.0"
gem "metricky", ">= 0.8.6"
gem "dalli"
gem "foundation_emails"
gem "rufus-scheduler"
gem "eve_online", ">= 0.33.0"
# gem "eve_online", git: "https://github.com/evemonk/eve_online.git", branch: "dev"
gem "omniauth-eve_online-sso"
gem "omniauth-rails_csrf_protection", ">= 0.1.2"
gem "jwt"
gem "rack-cors", require: "rack/cors"
gem "kaminari", ">= 1.2.0"
gem "kaminari-i18n", ">= 0.5.0"
gem "rails-html-sanitizer"
gem "draper", ">= 4.0.1"
gem "mobility"
gem "paper_trail", ">= 10.3.1"
gem "rails-settings-cached", ">= 2.1.1"
gem "sidekiq", require: false
gem "rpush", ">= 5.0.0"
gem "pghero", ">= 2.4.2"
gem "pg_query"
# gem "rubycritic", require: false
gem "swagger-blocks"
gem "http_logger", git: "https://github.com/biow0lf/http_logger.git", branch: "master"
gem "responders", ">= 3.0.0"
gem "rack-health"
gem "sitemap_generator"
gem "searchkick", ">= 4.3.0"
gem "typhoeus"
gem "sentry-raven"
gem "errbase"
gem "activerecord-nulldb-adapter", ">= 0.4.0"
gem "niceql"
gem "server_timing"
gem "traceroute", ">= 0.8.1"
# gem "strong_migrations"

gem "awesome_print", require: "ap"
gem "pry-rails"

gem "lograge", ">= 0.11.2"

gem "yabeda-prometheus"
gem "yabeda-rails", ">= 0.5.0"
gem "yabeda-sidekiq"
gem "yabeda-puma-plugin"

# gem "oink"

group :production do
  gem "newrelic_rpm"
  gem "rack-timeout"
end

group :development, :test do
  gem "dotenv-rails", ">= 2.7.5"
  gem "rspec-rails", ">= 4.0.0"
  gem "bullet", ">= 6.1.0"
  gem "factory_bot_rails", ">= 5.2.0"
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
  gem "anyway_config", "< 2" # For isolator
  gem "isolator", ">= 0.6.2"
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "spring-commands-rspec", require: false
  gem "spring-commands-rubocop", require: false
  gem "spring-commands-standard", require: false
  gem "consistency_fail", require: false
  gem "rails_best_practices", ">= 1.20.0"
  gem "active_record_doctor", ">= 1.7.1"
  # gem 'overcommit', require: false
  gem "cacheflow", ">= 0.1.1"
  gem "gemdiff", require: false
  gem "derailed_benchmarks"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
  gem "rails-controller-testing", ">= 1.0.4"
  gem "shoulda-matchers", ">= 4.3.0"
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

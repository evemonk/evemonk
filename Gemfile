# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version")

gem "rails", "7.0.7"

gem "pg"
gem "puma"
gem "importmap-rails", ">= 0.3.4"
gem "turbo-rails", ">= 0.7.4"
gem "stimulus-rails", ">= 0.3.9"
gem "jbuilder", "~> 2.11"
gem "dartsass-rails"
gem "bootsnap", ">= 1.4.4", require: false
gem "view_component"
gem "flipper"
gem "flipper-active_record"
gem "flipper-ui"
gem "inline_svg"
gem "bootstrap", "5.2.3"
gem "bootswatch",
  git: "https://github.com/thomaspark/bootswatch.git",
  tag: "v5.2.3"
gem "good_migrations"
gem "data_migrate", "10.0.3.rc"
gem "local_time"
gem "rails-i18n", "~> 7.0.7"
gem "http_accept_language"
gem "devise"
gem "devise-two-factor", ">= 5.0.0"
gem "devise-i18n"
gem "devise_zxcvbn"
gem "rqrcode"
gem "graphql"
gem "graphql-c_parser"
gem "graphiql-rails"
gem "rack-cors"
gem "pg_search"
gem "meta-tags"
gem "metricky"
gem "foundation_emails"
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
gem "redis-client"
gem "sidekiq"
gem "pghero"
gem "pg_query"
gem "noticed"
# gem "rubycritic", require: false
gem "responders"
gem "aws-sdk-s3"
gem "down"
gem "sitemap_generator"
gem "administrate"
gem "awesome_print", require: "ap"
gem "pry-rails"
gem "skylight"
gem "lograge"
gem "webrick"
gem "airbrake", "~> 13.0"
gem "prosopite"
gem "sshkit", require: false
gem "uri", ">= 0.12.2"
# gem "console_creep"

# gem "oink"

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
  gem "rubocop-performance", require: false
  gem "rubocop-graphql", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-capybara", require: false
  gem "standard", "1.30.1", require: false
  gem "squasher", require: false
  gem "brakeman", require: false
  gem "fasterer", require: false
  gem "license_finder", require: false
  gem "anyway_config" # For isolator
  gem "isolator"
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
  gem "rails-erd"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "rails-controller-testing"
  gem "shoulda-matchers"
  gem "rspec-its"
  gem "super_diff"
  # gem "rspec-stubbed_env"
  gem "simplecov"
  gem "simplecov-cobertura", require: false
  gem "database_rewinder"
  gem "webmock"
  gem "vcr"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "httplog"

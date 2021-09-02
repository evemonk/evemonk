# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version")

gem "rails", git: 'https://github.com/rails/rails.git', branch: 'main'

gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails", ">= 0.3.4"
gem "turbo-rails", ">= 0.7.4"
gem "stimulus-rails", ">= 0.3.9"
gem "jbuilder", "~> 2.7"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Sass to process CSS
# gem "sassc-rails", "~> 2.1"

# Use Tailwind CSS. See: https://github.com/rails/tailwindcss-rails
# gem "tailwindcss-rails", "~> 0.4.3"

# Use Active Model has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Active Storage variant
# gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

gem "good_migrations"
gem "local_time"
gem "rails-i18n", "~> 6.0.0"
gem "http_accept_language"
gem "countries"
gem "oj"
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
gem "omniauth-eve_online-sso", "0.2.0"
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
gem "fog-aws", require: false
gem "aws-sdk-s3"
gem "down"
gem "sitemap_generator"
gem "administrate"
gem "sentry-ruby"
gem "sentry-rails"
gem "sentry-sidekiq"
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
end

group :development do
  # Display speed badge on every html page with SQL times and flame graphs.
  # Note: Interferes with etag cache testing. Can be configured to work on production: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem "rack-mini-profiler", "~> 2.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "httplog"

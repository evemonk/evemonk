# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '6.0.0.beta3'
# gem 'rails', git: 'https://github.com/rails/rails.git',
#              branch: 'master'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'webpacker'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
# gem 'rufus-scheduler'
gem 'bcrypt'
# gem 'eve_online'
gem 'eve_online', git: 'https://github.com/evemonk/eve_online.git', branch: 'master'
# gem 'eve_online', path: '~/opensource/eve_online'
gem 'omniauth-eve_online-sso'
gem 'jwt'
gem 'rack-cors', require: 'rack/cors'
gem 'kaminari'
gem 'pundit'
gem 'dotenv-rails'
gem 'sidekiq', require: false
gem 'sidekiq-scheduler', require: false
gem 'sinatra', require: false
gem 'rpush'
gem 'pghero'
gem 'pg_query'
# gem 'rubycritic', require: false
gem 'swagger-blocks'
gem 'http_logger'
gem 'responders'
gem 'rack-health'
gem 'sitemap_generator'
gem 'rotp'
gem 'prerender_rails'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveStorage variant
# gem 'image_processing', '~> 1.2'

group :production do
  gem 'newrelic_rpm'
  gem 'rack-timeout'
end

group :development, :test do
  # gem 'rspec-rails'
  ['rspec-core', 'rspec-expectations', 'rspec-mocks', 'rspec-support'].each do |lib|
    gem lib, git: "https://github.com/rspec/#{ lib }.git", branch: 'master'
  end
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails.git', branch: '4-0-dev'
  gem 'awesome_print', require: 'ap'
  gem 'pry-rails'
  # gem 'bullet' # Current version don't support rails 6 yet
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'sql_tracker'
  gem 'bundler-audit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-thread_safety', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false
  gem 'mry', require: false
  gem 'squasher', require: false
  gem 'mdl', require: false
  gem 'brakeman', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec', require: false
  gem 'spring-commands-rubocop', require: false
  gem 'consistency_fail', require: false
  gem 'rails_best_practices'
  gem 'license_finder', require: false
  gem 'active_record_doctor'
  gem 'ed25519', '>= 1.2', '< 2.0' # net-ssh requires the following gems for ed25519 support
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0' # net-ssh requires the following gems for ed25519 support
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-faster-assets', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-rbenv-install', require: false
  # gem 'overcommit', require: false
  gem 'cacheflow'
  # gem 'licensed', require: false
  gem 'gemdiff', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'shoulda-callback-matchers', git: 'https://github.com/jdliss/shoulda-callback-matchers.git',
                                   branch: 'master'
  gem 'simplecov'
  gem 'database_rewinder'
  gem 'webmock'
  gem 'vcr'
end

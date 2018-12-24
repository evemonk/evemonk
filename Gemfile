# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', git: 'https://github.com/rails/rails.git',
             branch: 'master'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'webpacker', git: 'https://github.com/rails/webpacker.git',
                 branch: 'master'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
# gem 'rufus-scheduler'
gem 'bcrypt'
# gem 'eve_online'
gem 'eve_online', git: 'https://github.com/evemonk/eve_online.git', branch: 'refactoring'
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
gem 'responders', git: 'https://github.com/plataformatec/responders.git', branch: 'master' # Until next release
gem 'rack-health'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'image_processing', '~> 1.2'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'newrelic_rpm'
  gem 'rack-timeout'
end

group :development, :test do
  gem 'rspec-rails'
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
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rspec-its'
  gem 'shoulda-callback-matchers', git: 'https://github.com/jdliss/shoulda-callback-matchers.git',
                                   branch: 'master'
  gem 'simplecov'
  gem 'database_rewinder'
  gem 'webmock', git: 'https://github.com/bblimke/webmock.git',
                 branch: 'master' # Until next version with https://github.com/bblimke/webmock/pull/769/commits/9432aaa21b6b1bdc038b1c22537444f223643d8f
  gem 'vcr'
end

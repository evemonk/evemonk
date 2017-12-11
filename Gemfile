# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 5.2.0.beta2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

gem 'jquery-rails'
gem 'handlebars_assets'
gem 'js-routes'
gem 'bootstrap', '~> 4.0.0.beta2'
gem 'font-awesome-sass'
gem 'rufus-scheduler'
gem 'bcrypt'
# gem 'eve_online'
gem 'eve_online', git: 'https://github.com/biow0lf/eve_online.git', branch: 'master'
# gem 'eve_online', path: '~/opensource/eve_online'
gem 'omniauth-eve_online-sso'
gem 'rack-cors', require: 'rack/cors'
gem 'kaminari'
gem 'pundit'
gem 'draper'
gem 'dotenv-rails'
gem 'sidekiq', require: false
gem 'rpush'
gem 'rack-dev-mark'
gem 'pghero'
gem 'pg_query'
gem 'rubycritic', require: false
gem 'swagger-blocks'
gem 'http_logger'

group :production do
  gem 'lograge'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'awesome_print', require: 'ap'
  gem 'pry-rails'
  gem 'bullet'
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
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'brakeman', require: false
  gem 'consistency_fail', require: false
  gem 'rails_best_practices'
  gem 'license_finder'
  gem 'active_record_doctor'
  gem 'bcrypt_pbkdf' # for rbnacl-libsodium
  gem 'rbnacl', '< 4.0' # for rbnacl-libsodium
  gem 'rbnacl-libsodium' # for ssh-ed25519 support
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-faster-assets', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-rbenv-install', require: false
  # gem 'overcommit', require: false
  gem 'cacheflow'
end

group :test do
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'shoulda-callback-matchers', git: 'https://github.com/jdliss/shoulda-callback-matchers.git',
                                   branch: 'master'
  gem 'simplecov'
  gem 'codeclimate-test-reporter'
  gem 'database_rewinder'
  gem 'webmock'
  gem 'vcr'
end

source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'bcrypt'
gem 'swagger-blocks'
gem 'eve_online'
gem 'bullet'
gem 'has_secure_token'
gem 'activerecord-colored_log_subscriber'
gem 'good_migrations'
gem 'rack-cors', require: 'rack/cors'
gem 'kaminari'
gem 'draper'
gem 'rails-observers'
gem 'puma'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'pg'
  gem 'lograge'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'awesome_print', require: 'ap'
end

group :development do
  gem 'quiet_assets'
  gem 'pry-rails'
  gem 'brakeman', require: false
  gem 'rubocop', require: false
end

group :test do
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
end

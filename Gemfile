source 'https://rubygems.org'

gem 'rails', '~> 5.1.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'

gem 'bcrypt'
gem 'eve_online'
# gem 'eve_online', git: 'https://github.com/biow0lf/eve_online.git', branch: 'master'
# gem 'eve_online', path: '~/opensource/eve_online'
gem 'rack-cors', require: 'rack/cors'
gem 'kaminari'
gem 'draper', '3.0.0.pre1'
# gem 'dotenv-rails'
gem 'pundit'
gem 'sidekiq'
gem 'rpush'
gem 'rack-dev-mark'
gem 'pghero'
gem 'pg_query'

group :production do
  gem 'lograge'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'awesome_print', require: 'ap'
  gem 'pry-rails'
  gem 'bullet'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'sql_tracker'
  gem 'bundler-audit'
  # rubocop version locked due config. Update rubocop config on gem update.
  gem 'rubocop', '0.48.1', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'brakeman', require: false
  gem 'consistency_fail', require: false
  gem 'rails_best_practices'
  # gem 'active_record_doctor'
  gem 'bcrypt_pbkdf' # for rbnacl-libsodium
  gem 'rbnacl', '< 4.0' # for rbnacl-libsodium
  gem 'rbnacl-libsodium' # for ssh-ed25519 support
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-faster-assets'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'
end

group :test do
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'shoulda-callback-matchers', git: 'https://github.com/jdliss/shoulda-callback-matchers.git',
                                   branch: 'master'
  gem 'simplecov'
  gem 'codeclimate-test-reporter'
  gem 'database_rewinder', git: 'https://github.com/amatsuda/database_rewinder.git',
                           branch: 'master'
  gem 'webmock'
end

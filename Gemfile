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

group :development, :test do
end

group :development do
  # Display speed badge on every html page with SQL times and flame graphs.
  # Note: Interferes with etag cache testing. Can be configured to work on production: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem "rack-mini-profiler", "~> 2.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

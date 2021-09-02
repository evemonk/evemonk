# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version")

gem "rails", git: 'https://github.com/rails/rails.git', branch: 'main'

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use Puma as the app server
gem "puma", "~> 5.0"
# Manage modern JavaScript using ESM without transpiling or bundling
gem "importmap-rails", ">= 0.3.4"
# Hotwire's SPA-like page accelerator. Read more: https://turbo.hotwired.dev
gem "turbo-rails", ">= 0.7.4"
# Hotwire's modest JavaScript framework for the HTML you already have. Read more: https://stimulus.hotwired.dev
gem "stimulus-rails", ">= 0.3.9"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
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

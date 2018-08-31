# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

# For New Relic health check
use Rack::Health

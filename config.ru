# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

# For New Relic health check
use Rack::Health

# Export metrics for prometheus
use Yabeda::Prometheus::Exporter

run Rails.application

# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV["SENTRY_DSN"]
  config.breadcrumbs_logger = [:active_support_logger]
  config.traces_sample_rate = 0.1
  config.async = lambda { |event, hint| SentryJob.perform_later(event, hint) }
end

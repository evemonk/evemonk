# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV["SENTRY_DSN"]
  config.enabled_environments = "production"
  config.breadcrumbs_logger = [:active_support_logger]
  config.traces_sample_rate = 0.1
  config.async = lambda { |event, hint| SentryJob.perform_later(event, hint) }
  config.excluded_exceptions += ["EveOnline::Exceptions::InternalServerError",
    "EveOnline::Exceptions::BadGateway",
    "EveOnline::Exceptions::ServiceUnavailable",
    "EveOnline::Exceptions::Timeout",
    "EveOnline::Exceptions::ResourceNotFound",
    "Searchkick::ImportError",
    "OpenSSL::SSL::SSLError",
    "Faraday::Error::TimeoutError"]
end

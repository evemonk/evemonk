# frozen_string_literal: true

if Rails.env.production?
  Sentry.init do |config|
    config.dsn = ENV.fetch("SENTRY_DSN", nil)
    config.enabled_environments = ["production"]
    config.breadcrumbs_logger = [:active_support_logger]
    config.async = lambda { |event, hint| SentryJob.perform_later(event, hint) }
    config.excluded_exceptions += ["EveOnline::Exceptions::InternalServerError",
      "EveOnline::Exceptions::BadGateway",
      "EveOnline::Exceptions::ServiceUnavailable",
      "EveOnline::Exceptions::Timeout",
      "EveOnline::Exceptions::ResourceNotFound",
      "Faraday::Error::TimeoutError",
      "Sentry::ExternalError"]
  end
end

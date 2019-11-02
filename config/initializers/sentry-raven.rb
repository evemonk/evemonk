# frozen_string_literal: true

if Rails.env.production? && ENV["SENTRY_DSN"]
  Raven.configure do |config|
    config.dsn = ENV["SENTRY_DSN"]

    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)

    config.excluded_exceptions += ["EveOnline::Exceptions::InternalServerError",
                                   "EveOnline::Exceptions::BadGateway",
                                   "EveOnline::Exceptions::ServiceUnavailable",
                                   "EveOnline::Exceptions::Timeout",
                                   "Searchkick::ImportError",]

    config.silence_ready = true

    config.async = lambda { |event| SentryJob.perform_later(event) }
  end
end

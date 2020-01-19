# frozen_string_literal: true

module Eve
  class LocalAsteroidBeltsJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError

    def perform
      Eve::LocalAsteroidBeltsImporter.new.import
    end
  end
end

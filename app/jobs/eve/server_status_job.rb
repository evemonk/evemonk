# frozen_string_literal: true

module Eve
  class ServerStatusJob < ActiveJob::Base
    queue_as :server_status

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError

    def perform
      Eve::ServerStatusImporter.new.import
    end
  end
end

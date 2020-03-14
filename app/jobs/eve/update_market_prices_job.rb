# frozen_string_literal: true

module Eve
  class UpdateMarketPricesJob < ActiveJob::Base
    queue_as :important

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError,
      Faraday::ConnectionFailed

    def perform
      Eve::MarketPricesImporter.new.import
    end
  end
end

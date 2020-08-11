# frozen_string_literal: true

module Eve
  class RegionContractsJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(region_id, page = 1)
      Eve::RegionContractsImporter.new(region_id, page).import
    end
  end
end

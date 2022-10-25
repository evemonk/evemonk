# frozen_string_literal: true

module Eve
  class RegionContractsJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(id, page = 1)
      Eve::RegionContractsImporter.new(id, page).import
    end
  end
end

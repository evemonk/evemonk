# frozen_string_literal: true

module Eve
  class UpdateCorporationAllianceHistoryJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(corporation_id)
      Eve::CorporationAllianceHistoryImporter.new(corporation_id).import
    end
  end
end

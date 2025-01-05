# frozen_string_literal: true

module Eve
  class UpdateStationJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(station_id)
      Eve::StationImporter.new(station_id).import
    end
  end
end

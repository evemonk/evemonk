# frozen_string_literal: true

module Eve
  class UpdatePlanetJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(planet_id)
      Eve::PlanetImporter.new(planet_id).import
    end
  end
end

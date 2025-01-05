# frozen_string_literal: true

module Eve
  class UpdateAsteroidBeltJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(planet_id, asteroid_belt_id)
      Eve::AsteroidBeltImporter.new(planet_id, asteroid_belt_id).import
    end
  end
end

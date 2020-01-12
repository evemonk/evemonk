# frozen_string_literal: true

module Eve
  class UpdateMoonJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError

    def perform(planet_id, moon_id)
      Eve::MoonImporter.new(planet_id, moon_id).import
    end
  end
end

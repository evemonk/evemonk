# frozen_string_literal: true

module Eve
  class UpdateConstellationJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError,
      Faraday::ConnectionFailed

    def perform(constellation_id)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::ConstellationImporter.new(constellation_id, locale).import
      end
    end
  end
end

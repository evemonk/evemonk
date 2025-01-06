# frozen_string_literal: true

module Eve
  class UpdateRacesJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform
      if Rails.configuration.evemonk.jobs[:eve][:races]
        LanguageMapper::LANGUAGES.each_key do |locale|
          Eve::RacesImporter.new(locale).import
        end
      end
    end
  end
end

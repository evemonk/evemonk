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
      if Flipper.enabled?(:eve_races)
        LanguageMapper::LANGUAGES.each_value do |language|
          Eve::RacesImporter.new(language).import
        end
      end
    end
  end
end

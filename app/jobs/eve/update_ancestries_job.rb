# frozen_string_literal: true

module Eve
  class UpdateAncestriesJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform
      if Rails.configuration.evemonk.jobs[:eve][:ancestries]
        LanguageMapper::LANGUAGES.each_value do |language|
          Eve::AncestriesImporter.new(language).import
        end
      end
    end
  end
end

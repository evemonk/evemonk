# frozen_string_literal: true

module Eve
  class UpdateBloodlinesJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform
      if Rails.configuration.evemonk.jobs[:eve][:bloodlines]
        LanguageMapper::LANGUAGES.each_key do |locale|
          Eve::BloodlinesImporter.new(locale).import
        end
      end
    end
  end
end

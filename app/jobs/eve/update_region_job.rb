# frozen_string_literal: true

module Eve
  class UpdateRegionJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError

    def perform(region_id)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::RegionImporter.new(region_id, locale).import
      end
    end
  end
end

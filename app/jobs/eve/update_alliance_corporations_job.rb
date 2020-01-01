# frozen_string_literal: true

module Eve
  class UpdateAllianceCorporationsJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError

    def perform(alliance_id)
      Eve::AllianceCorporationsImporter.new(alliance_id).import
    end
  end
end

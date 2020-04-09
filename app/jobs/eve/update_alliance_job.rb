# frozen_string_literal: true

module Eve
  class UpdateAllianceJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(alliance_id)
      Eve::AllianceImporter.new(alliance_id).import
    end
  end
end

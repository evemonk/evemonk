# frozen_string_literal: true

module Eve
  class UpdateStargateJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(stargate_id)
      Eve::StargateImporter.new(stargate_id).import
    end
  end
end

# frozen_string_literal: true

module Eve
  class UpdateStargateJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(stargate_id)
      Eve::StargateImporter.new(stargate_id).import
    end
  end
end

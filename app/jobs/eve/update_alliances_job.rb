# frozen_string_literal: true

module Eve
  class UpdateAlliancesJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform
      if Flipper.enabled?(:eve_update_alliances_job)
        Eve::AlliancesImporter.new.import
      end
    end
  end
end

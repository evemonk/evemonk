# frozen_string_literal: true

module Eve
  class UpdateAllianceCorporationsJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(id)
      if Rails.configuration.evemonk.jobs[:eve][:update_alliance_corporations]
        Eve::AllianceCorporationsImporter.new(id).import
      end
    end
  end
end

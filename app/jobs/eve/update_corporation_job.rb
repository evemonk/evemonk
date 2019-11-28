# frozen_string_literal: true

module Eve
  class UpdateCorporationJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform(corporation_id)
      Eve::CorporationImporter.new(corporation_id).import
    end
  end
end

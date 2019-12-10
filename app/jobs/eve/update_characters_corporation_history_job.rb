# frozen_string_literal: true

module Eve
  class UpdateCharactersCorporationHistoryJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform
      Eve::CharactersCorporationHistoryImporter.new.import
    end
  end
end

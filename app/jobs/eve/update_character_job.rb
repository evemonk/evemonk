# frozen_string_literal: true

module Eve
  class UpdateCharacterJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform(character_id)
      Eve::CharacterImporter.new(character_id).import
      # Eve::CharacterCorporationHistoryImporter.new(character_id).import
    end
  end
end

# frozen_string_literal: true

module Eve
  class UpdateCharacterPortraitJob < ApplicationJob
    queue_as :default

    retry_on Down::TimeoutError,
      Down::ConnectionError

    def perform(character_id)
      Eve::CharacterPortraitImporter.new(character_id).import
    end
  end
end

# frozen_string_literal: true

module Eve
  class UpdateCharacterPortraitJob < ApplicationJob
    queue_as :default

    def perform(character_id)
      Eve::CharacterPortraitImporter.new(character_id).import
    end
  end
end

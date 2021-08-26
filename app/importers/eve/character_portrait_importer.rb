# frozen_string_literal: true

require "down"

module Eve
  class CharacterPortraitImporter < BaseImporter
    attr_reader :character_id

    PORTRAIT_URL = "https://images.evetech.net/characters/%s/portrait"

    def initialize(character_id)
      @character_id = character_id
    end

    def import
      eve_character = Eve::Character.find_or_initialize_by(character_id: character_id)

      tempfile = Down.download(PORTRAIT_URL % character_id)

      eve_character.portrait.attach(io: tempfile, filename: "#{character_id}.jpg")

      eve_character.save!
    end
  end
end

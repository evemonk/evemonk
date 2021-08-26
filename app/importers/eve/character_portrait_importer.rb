# frozen_string_literal: true

module Eve
  class CharacterPortraitImporter < BaseImporter
    attr_reader :character_id

    # PORTRAIT_URL = "https://images.evetech.net/characters/%s/portrait"

    def initialize(character_id)
      @character_id = character_id
    end

    def import
      # eve_character = Eve::Character.find_or_initialize_by(character_id: character_id)
      #
      # downloaded_image = URI.parse("https://images.evetech.net/characters/1338057886/portrait").open
      # Eve::Character.first.portrait.attach(io: downloaded_image)
      #
      # eve_character.portrait.attach(io: downloaded_image, filename: "#{character_id}.jpg")
    end
  end
end

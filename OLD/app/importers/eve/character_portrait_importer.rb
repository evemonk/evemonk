# frozen_string_literal: true

module Eve
  class CharacterPortraitImporter < BaseImporter
    attr_reader :id

    CHARACTERS_PORTRAIT_URL = "https://images.evetech.net/characters/%<id>s/portrait"

    def initialize(id)
      @id = id
    end

    def import
      eve_character = Eve::Character.find_or_initialize_by(id: id)

      tempfile = Down.download(format(CHARACTERS_PORTRAIT_URL, id: id))

      eve_character.portrait.attach(io: tempfile, filename: "#{id}.jpg")

      eve_character.save!
    end
  end
end

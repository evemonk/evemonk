# frozen_string_literal: true

module Eve
  class CharacterImporter < BaseImporter
    attr_reader :character_id

    def initialize(character_id)
      @character_id = character_id
    end

    def import!
      eve_character = Eve::Character.find_or_initialize_by(character_id: character_id)

      eve_character.update!(esi.as_json)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_character.destroy!
    end

    def esi
      @esi ||= EveOnline::ESI::Character.new(character_id: character_id)
    end
  end
end

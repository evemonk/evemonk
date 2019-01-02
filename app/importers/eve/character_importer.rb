# frozen_string_literal: true

module Eve
  class CharacterImporter
    attr_reader :character_id

    def initialize(character_id)
      @character_id = character_id
    end

    def import
      eve_character = Eve::Character.find_or_initialize_by(character_id: character_id)

      eveonline_esi_character = EveOnline::ESI::Character.new(character_id: character_id)

      etag = Etag.find_or_initialize_by(url: eveonline_esi_character.url)

      eveonline_esi_character.etag = etag.etag

      return if eveonline_esi_character.not_modified?

      # FIXME: character security status always updates
      eve_character.update!(eveonline_esi_character.as_json)

      etag.update!(etag: eveonline_esi_character.etag)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_character.destroy!
    end
  end
end

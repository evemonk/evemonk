# frozen_string_literal: true

module Eve
  class CharacterImporter < BaseImporter
    attr_reader :character_id

    def initialize(character_id)
      @character_id = character_id
    end

    def import
      import! do
        eve_character = Eve::Character.find_or_initialize_by(character_id: character_id)

        return if esi.not_modified?

        eve_character.update!(esi.as_json)

        update_etag
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Character ID #{character_id}")

        etag.destroy!

        eve_character.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Character.new(character_id: character_id)
    end
  end
end

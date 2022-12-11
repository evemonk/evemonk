# frozen_string_literal: true

module Eve
  class CharacterImporter < BaseImporter
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def import
      import! do
        eve_character = Eve::Character.find_or_initialize_by(id: id)

        return if esi.not_modified?

        eve_character.update!(esi.as_json)

        update_etag
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Character ID #{id}")

        etag.destroy!

        eve_character.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Character.new(character_id: id)
    end
  end
end

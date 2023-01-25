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

        eve_character.update!(esi.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Character ID #{id}")

        eve_character.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Character.new(character_id: id)
    end
  end
end

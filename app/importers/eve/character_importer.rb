# frozen_string_literal: true

module Eve
  class CharacterImporter < BaseImporter
    attr_reader :id

    # @param id [Integer] Eve Character ID
    def initialize(id)
      @id = id
    end

    def import
      import! do
        eve_character = Eve::Character.find_or_initialize_by(id: id)

        eve_character.update!(character.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Character ID #{id}")

        DeletedCharacter.find_or_create_by!(id: id).touch # rubocop:disable Rails/SkipsModelValidations

        eve_character.destroy!
      end
    end

    private

    def client
      @client ||= EveOnline::ESI::Client.new(cache: true, cache_store: Rails.cache)
    end

    def character
      @character ||= client.characters.retrieve(id: id)
    end
  end
end

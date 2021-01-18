# frozen_string_literal: true

module Eve
  class CharacterCorporationHistoryImporter < BaseImporter
    attr_reader :character_id

    def initialize(character_id)
      @character_id = character_id
    end

    def import
      import! do
        return if esi.not_modified?

        eve_character = Eve::Character.find_by!(character_id: character_id)

        update_etag
      end
    end

    # def import!
    #   eve_character = Eve::Character.find_by!(character_id: character_id)
    #
    #   esi.entries.each do |entry|
    #     history = eve_character.character_corporation_histories
    #       .find_or_initialize_by(record_id: entry.record_id)
    #
    #     history.update!(entry.as_json)
    #   end
    # rescue ActiveRecord::RecordNotFound
    #   Rails.logger.info("Character with ID #{character_id} not found")
    # end

    def esi
      @esi ||= EveOnline::ESI::CharacterCorporationHistory.new(character_id: character_id)
    end
  end
end

# frozen_string_literal: true

module Eve
  class CharacterCorporationHistoryImporter < BaseImporter
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def import
      import! do
        eve_character = Eve::Character.find(id)

        esi.entries.each do |entry|
          history = eve_character.character_corporation_histories
            .find_or_initialize_by(record_id: entry.record_id)

          history.update!(entry.as_json)
        end
      rescue ActiveRecord::RecordNotFound
        Rails.logger.info("Character with ID #{id} not found")
      end
    end

    def esi
      @esi ||= EveOnline::ESI::CharacterCorporationHistory.new(character_id: id)
    end
  end
end

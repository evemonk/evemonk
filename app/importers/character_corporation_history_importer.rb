# frozen_string_literal: true

class CharacterCorporationHistoryImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    esi = EveOnline::ESI::CharacterCorporationHistory.new(character_id: character_id)

    ActiveRecord::Base.transaction do
      esi.entries.each do |entry|
        history = character.character_corporation_histories
          .find_or_initialize_by(record_id: entry.record_id)

        history.update!(entry.as_json)
      end
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end

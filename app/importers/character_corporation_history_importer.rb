# frozen_string_literal: true

class CharacterCorporationHistoryImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    ActiveRecord::Base.transaction do
      character = Character.find_by!(character_id: character_id)

      esi = EveOnline::ESI::CharacterCorporationHistory.new(character_id: character_id)

      esi.entries.each do |entry|
        history = character.character_corporation_histories
          .find_or_initialize_by(record_id: entry.record_id)

        history.update!(entry.as_json)
      end
    end
  end
end

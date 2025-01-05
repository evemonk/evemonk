# frozen_string_literal: true

class CharacterCorporationHistoryImporter < CharacterBaseImporter
  def import!
    esi.entries.each do |entry|
      history = character.character_corporation_histories
        .find_or_initialize_by(record_id: entry.record_id)

      history.update!(entry.as_json)
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterCorporationHistory.new(character_id: character.character_id)
  end
end

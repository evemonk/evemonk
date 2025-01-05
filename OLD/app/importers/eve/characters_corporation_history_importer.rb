# frozen_string_literal: true

module Eve
  class CharactersCorporationHistoryImporter
    def import
      character_ids = Eve::Character.ids

      character_ids.sort.each do |character_id|
        Eve::UpdateCharacterCorporationHistoryJob.perform_later(character_id)
      end
    end
  end
end

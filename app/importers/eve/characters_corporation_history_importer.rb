# frozen_string_literal: true

# TODO: update
module Eve
  class CharactersCorporationHistoryImporter
    def import
      character_ids = Eve::Character.pluck(:character_id)

      character_ids.each do |character_id|
        Eve::UpdateCharacterCorporationHistoryJob.perform_later(character_id)
      end
    end
  end
end

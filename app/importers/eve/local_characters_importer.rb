# frozen_string_literal: true

module Eve
  class LocalCharactersImporter
    def import
      Eve::Character.ids.sort.each do |character_id|
        Eve::UpdateCharacterJob.perform_later(character_id)
      end
    end
  end
end

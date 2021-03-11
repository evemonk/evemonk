# frozen_string_literal: true

# TODO: update
module Eve
  class LocalCharactersImporter
    def import
      Eve::Character.pluck(:character_id).each do |character_id|
        Eve::UpdateCharacterJob.perform_later(character_id)
      end
    end
  end
end

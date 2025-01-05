# frozen_string_literal: true

module Eve
  class CharactersImporter
    def import
      character_ids = Eve::Character.ids

      alliance_creator_ids = Eve::Alliance.pluck(:creator_id)

      corporation_ceo_ids = Eve::Corporation.where.not(ceo_id: 0).pluck(:ceo_id)

      corporation_creator_ids = Eve::Corporation.where.not(creator_id: 1).pluck(:creator_id)

      character_ids_to_create = (alliance_creator_ids + corporation_ceo_ids + corporation_creator_ids).uniq - character_ids

      character_ids_to_create.sort.each do |character_id|
        Eve::UpdateCharacterJob.perform_later(character_id)
      end
    end
  end
end

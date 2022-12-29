# frozen_string_literal: true

module Eve
  class CorporationsImporter
    def import
      imported_corporation_ids = Eve::Corporation.pluck(:corporation_id)

      corporation_ids_1 = Eve::Character.distinct.pluck(:corporation_id)

      corporation_ids_2 = Eve::CharacterCorporationHistory.distinct.pluck(:corporation_id)

      corporation_ids_3 = Eve::Bloodline.pluck(:corporation_id).uniq

      # WTF: CCP, how is creator_corporation with id 0?
      # https://esi.evetech.net/latest/alliances/1966049571/?datasource=tranquility
      corporation_ids_4 = Eve::Alliance.where.not(creator_corporation_id: 0)
        .pluck(:creator_corporation_id).uniq

      corporation_ids_5 = Eve::Alliance.pluck(:executor_corporation_id).uniq

      corporation_ids_6 = Eve::CorporationAllianceHistory.pluck(:corporation_id).uniq

      corporation_ids_7 = Eve::Faction.where.not(corporation_id: nil)
        .pluck(:corporation_id).uniq

      corporation_ids_8 = Eve::Faction.where.not(militia_corporation_id: nil)
        .pluck(:militia_corporation_id).uniq

      corporation_ids_9 = ::Character.pluck(:corporation_id).uniq

      new_corporation_ids = (corporation_ids_1 + corporation_ids_2 +
        corporation_ids_3 + corporation_ids_4 + corporation_ids_5 +
        corporation_ids_6 + corporation_ids_7 + corporation_ids_8 +
        corporation_ids_9).uniq

      corporation_ids = new_corporation_ids - imported_corporation_ids

      corporation_ids.each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)
      end
    end
  end
end

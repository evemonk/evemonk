# frozen_string_literal: true

# TODO: update
module Eve
  class CorporationsImporter
    def import
      imported_corporation_ids = Eve::Corporation.pluck(:corporation_id)

      corporation_ids1 = Eve::Character.pluck(:corporation_id).uniq

      corporation_ids2 = Eve::CharacterCorporationHistory.pluck(:corporation_id).uniq

      corporation_ids3 = Eve::Bloodline.pluck(:corporation_id).uniq

      # WTF: CCP, how is creator_corporation with id 0?
      # https://esi.evetech.net/latest/alliances/1966049571/?datasource=tranquility
      corporation_ids4 = Eve::Alliance.where.not(creator_corporation_id: 0)
        .pluck(:creator_corporation_id).uniq

      corporation_ids5 = Eve::Alliance.pluck(:executor_corporation_id).uniq

      corporation_ids6 = Eve::CorporationAllianceHistory.pluck(:corporation_id).uniq

      corporation_ids7 = Eve::Faction.where.not(corporation_id: nil)
        .pluck(:corporation_id).uniq

      corporation_ids8 = Eve::Faction.where.not(militia_corporation_id: nil)
        .pluck(:militia_corporation_id).uniq

      corporation_ids9 = ::Character.pluck(:corporation_id).uniq

      new_corporation_ids = (corporation_ids1 + corporation_ids2 +
        corporation_ids3 + corporation_ids4 + corporation_ids5 +
        corporation_ids6 + corporation_ids7 + corporation_ids8 +
        corporation_ids9).uniq

      corporation_ids = new_corporation_ids - imported_corporation_ids

      corporation_ids.each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)
      end
    end
  end
end

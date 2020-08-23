# frozen_string_literal: true

module Eve
  class CorporationsImporter
    def import
      imported_corporation_ids = Eve::Corporation.pluck(:corporation_id)

      corporation_ids1 = Eve::AllianceCorporation.pluck(:corporation_id).uniq

      corporation_ids2 = Eve::Character.pluck(:corporation_id).uniq

      corporation_ids3 = Eve::CharacterCorporationHistory.pluck(:corporation_id).uniq

      corporation_ids4 = Eve::Bloodline.pluck(:corporation_id).uniq

      corporation_ids5 = Eve::Alliance.pluck(:creator_corporation_id).uniq

      corporation_ids6 = Eve::Alliance.pluck(:executor_corporation_id).uniq

      corporation_ids7 = Eve::CorporationAllianceHistory.pluck(:corporation_id).uniq

      corporation_ids8 = Eve::Faction.where.not(corporation_id: nil).pluck(:corporation_id).uniq

      corporation_ids9 = Eve::Faction.where.not(militia_corporation_id: nil).pluck(:militia_corporation_id).uniq

      corporation_ids10 = ::Character.pluck(:corporation_id).uniq

      new_corporation_ids = (corporation_ids1 + corporation_ids2 + corporation_ids3 +
        corporation_ids4 + corporation_ids5 + corporation_ids6 + corporation_ids7 +
        corporation_ids8 + corporation_ids9 + corporation_ids10).uniq

      corporation_ids = new_corporation_ids - imported_corporation_ids

      corporation_ids.each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)
      end
    end
  end
end

# frozen_string_literal: true

module Eve
  class CorporationsImporter
    def import
      corporation_ids1 = Eve::AllianceCorporation.pluck(:corporation_id).uniq

      corporation_ids2 = Eve::Character.pluck(:corporation_id).uniq

      corporation_ids3 = Eve::Corporation.pluck(:corporation_id).uniq

      corporation_ids4 = Eve::CharacterCorporationHistory.pluck(:corporation_id).uniq

      corporation_ids = (corporation_ids1 + corporation_ids2 + corporation_ids3 + corporation_ids4).uniq

      corporation_ids.each do |corporation_id|
        Eve::CorporationImporterWorker.perform_async(corporation_id)
      end
    end
  end
end

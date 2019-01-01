# frozen_string_literal: true

module Eve
  class CorporationsImporter
    def import
      corporations_ids = Eve::AllianceCorporation.pluck(:corporation_id).uniq

      corporations_ids.each do |corporation_id|
        Eve::CorporationImporterWorker.perform_async(corporation_id)
      end
    end
  end
end

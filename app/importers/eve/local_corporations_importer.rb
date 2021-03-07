# frozen_string_literal: true

module Eve
  class LocalCorporationsImporter
    def import
      Eve::CorporationRepository.corporation_ids.each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)
      end
    end
  end
end

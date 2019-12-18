# frozen_string_literal: true

module Eve
  class LocalCorporationsImporter
    def import
      Eve::Corporation.pluck(:corporation_id).each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)
      end
    end
  end
end

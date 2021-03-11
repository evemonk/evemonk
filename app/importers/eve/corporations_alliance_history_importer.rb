# frozen_string_literal: true

# TODO: update
module Eve
  class CorporationsAllianceHistoryImporter
    def import
      Eve::Corporation.pluck(:corporation_id).each do |corporation_id|
        Eve::UpdateCorporationAllianceHistoryJob.perform_later(corporation_id)
      end
    end
  end
end

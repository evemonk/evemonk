# frozen_string_literal: true

module Eve
  class LocalAlliancesImporter
    def import
      Eve::Alliance.pluck(:alliance_id).each do |alliance_id|
        Eve::UpdateAllianceJob.perform_later(alliance_id)
      end
    end
  end
end

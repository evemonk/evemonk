# frozen_string_literal: true

module Eve
  class LocalAlliancesImporter
    def import
      Eve::AllianceRepository.alliance_ids.each do |alliance_id|
        Eve::UpdateAllianceJob.perform_later(alliance_id)
      end
    end
  end
end

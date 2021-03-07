# frozen_string_literal: true

module Eve
  class AlliancesCorporationsImporter
    def import
      Eve::AllianceRepository.alliance_ids.each do |alliance_id|
        Eve::UpdateAllianceCorporationsJob.perform_later(alliance_id)
      end
    end
  end
end

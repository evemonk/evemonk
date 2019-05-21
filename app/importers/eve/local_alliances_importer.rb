# frozen_string_literal: true

module Eve
  class LocalAlliancesImporter
    def import
      Eve::Alliance.pluck(:alliance_id).each do |alliance_id|
        Eve::AllianceImporterWorker.perform_async(alliance_id)
      end
    end
  end
end

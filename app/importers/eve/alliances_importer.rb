# frozen_string_literal: true

module Eve
  class AlliancesImporter
    def import
      alliance_ids = EveOnline::ESI::Alliances.new.alliance_ids

      alliance_ids.each do |alliance_id|
        Eve::AllianceImporterWorker.perform_async(alliance_id)
      end
    end
  end
end

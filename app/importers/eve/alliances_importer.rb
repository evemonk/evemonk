# frozen_string_literal: true

module Eve
  class AlliancesImporter
    def import
      current_etag = Redis.current.get("alliances:#{ I18n.locale }:etag")

      eveonline_esi_alliances = EveOnline::ESI::Alliances.new(etag: current_etag)

      return if eveonline_esi_alliances.not_modified?

      eveonline_esi_alliances.alliance_ids.each do |alliance_id|
        Eve::AllianceImporterWorker.perform_async(alliance_id)
      end

      Redis.current.set("alliances:#{ I18n.locale }:etag", eveonline_esi_alliances.etag)
    end
  end
end

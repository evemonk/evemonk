# frozen_string_literal: true

module Eve
  class AlliancesImporter
    def import
      etag = Redis.current.get("alliances:#{ I18n.locale }:etag")

      alliances = EveOnline::ESI::Alliances.new(etag: etag)

      return if alliances.not_modified?

      alliances.alliance_ids.each do |alliance_id|
        Eve::AllianceImporterWorker.perform_async(alliance_id)
      end

      Redis.current.set("alliances:#{ I18n.locale }:etag", alliances.etag)
    end
  end
end

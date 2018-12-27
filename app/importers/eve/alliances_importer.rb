# frozen_string_literal: true

module Eve
  class AlliancesImporter
    def import
      eveonline_esi_alliances = EveOnline::ESI::Alliances.new

      etag = Etag.find_or_initialize_by(url: eveonline_esi_alliances.url)

      eveonline_esi_alliances.etag = etag.etag

      return if eveonline_esi_alliances.not_modified?

      eveonline_esi_alliances.alliance_ids.each do |alliance_id|
        Eve::AllianceImporterWorker.perform_async(alliance_id)
      end

      etag.update!(etag: eveonline_esi_alliances.etag)
    end
  end
end

# frozen_string_literal: true

module Eve
  class AlliancesImporter
    def import
      esi = EveOnline::ESI::Alliances.new

      etag = Etag.find_or_initialize_by(url: esi.url)

      esi.etag = etag.etag

      return if esi.not_modified?

      esi.alliance_ids.each do |alliance_id|
        Eve::AllianceImporterWorker.perform_async(alliance_id)
      end

      etag.update!(etag: esi.etag)
    end
  end
end

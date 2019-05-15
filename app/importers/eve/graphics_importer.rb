# frozen_string_literal: true

module Eve
  class GraphicsImporter
    def import
      esi = EveOnline::ESI::UniverseGraphics.new

      etag = Etag.find_or_initialize_by(url: esi.url)

      esi.etag = etag.etag

      return if esi.not_modified?

      esi.graphic_ids.each do |graphic_id|
        Eve::GraphicImporterWorker.perform_async(graphic_id)
      end

      etag.update!(etag: esi.etag)
    end
  end
end

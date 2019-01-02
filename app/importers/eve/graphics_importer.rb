# frozen_string_literal: true

module Eve
  class GraphicsImporter
    def import
      eveonline_esi_graphics = EveOnline::ESI::UniverseGraphics.new

      etag = Etag.find_or_initialize_by(url: eveonline_esi_graphics.url)

      eveonline_esi_graphics.etag = etag.etag

      return if eveonline_esi_graphics.not_modified?

      eveonline_esi_graphics.graphic_ids.each do |graphic_id|
        Eve::GraphicImporterWorker.perform_async(graphic_id)
      end

      etag.update!(etag: eveonline_esi_graphics.etag)
    end
  end
end

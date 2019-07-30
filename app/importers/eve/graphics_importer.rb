# frozen_string_literal: true

module Eve
  class GraphicsImporter
    attr_reader :esi

    def initialize
      @esi = EveOnline::ESI::UniverseGraphics.new
    end

    def import
      ActiveRecord::Base.transaction do
        esi.etag = etag.etag

        return if esi.not_modified?

        import_new_graphics

        remove_old_graphics

        etag.update!(etag: esi.etag)
      end
    end

    private

    def etag
      @etag ||= Eve::Etag.find_or_initialize_by(url: esi.url)
    end

    def import_new_graphics
      esi.graphic_ids.each do |graphic_id|
        unless Eve::Graphic.exists?(graphic_id: graphic_id)
          Eve::GraphicImporterWorker.perform_async(graphic_id)
        end
      end
    end

    def remove_old_graphics
      eve_graphic_ids = Eve::Graphic.pluck(:graphic_id)

      graphic_ids_to_remove = eve_graphic_ids - esi.graphic_ids

      graphic_ids_to_remove.each do |graphic_id|
        eve_graphic = Eve::Graphic.find_or_initialize_by(graphic_id: graphic_id)

        eve_graphic.destroy!
      end
    end
  end
end

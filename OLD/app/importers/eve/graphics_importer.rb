# frozen_string_literal: true

module Eve
  class GraphicsImporter < BaseImporter
    def import
      import! do
        import_new_graphics

        remove_old_graphics
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseGraphics.new
    end

    private

    def import_new_graphics
      esi.graphic_ids.each do |graphic_id|
        unless Eve::Graphic.exists?(id: graphic_id)
          Eve::UpdateGraphicJob.perform_later(graphic_id)
        end
      end
    end

    def remove_old_graphics
      eve_graphic_ids = Eve::Graphic.ids

      graphic_ids_to_remove = eve_graphic_ids - esi.graphic_ids

      graphic_ids_to_remove.each do |graphic_id|
        eve_graphic = Eve::Graphic.find_or_initialize_by(id: graphic_id)

        eve_graphic.destroy!
      end
    end
  end
end

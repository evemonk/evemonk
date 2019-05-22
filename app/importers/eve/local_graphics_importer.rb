# frozen_string_literal: true

module Eve
  class LocalGraphicsImporter
    def import
      Eve::Graphic.pluck(:graphic_id).each do |graphic_id|
        Eve::GraphicImporterWorker.perform_async(graphic_id)
      end
    end
  end
end

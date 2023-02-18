# frozen_string_literal: true

module Eve
  class LocalGraphicsImporter
    def import
      Eve::Graphic.ids.each do |id|
        Eve::UpdateGraphicJob.perform_later(id)
      end
    end
  end
end

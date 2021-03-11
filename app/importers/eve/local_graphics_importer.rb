# frozen_string_literal: true

# TODO: update
module Eve
  class LocalGraphicsImporter
    def import
      Eve::Graphic.pluck(:graphic_id).each do |graphic_id|
        Eve::UpdateGraphicJob.perform_later(graphic_id)
      end
    end
  end
end

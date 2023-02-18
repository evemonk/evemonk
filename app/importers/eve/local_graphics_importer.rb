# frozen_string_literal: true

module Eve
  class LocalGraphicsImporter
    def import
      Eve::Graphic.pluck(:id).each do |graphic_id|
        Eve::UpdateGraphicJob.perform_later(graphic_id)
      end
    end
  end
end

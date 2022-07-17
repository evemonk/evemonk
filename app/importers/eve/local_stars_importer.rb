# frozen_string_literal: true

module Eve
  class LocalStarsImporter
    def import
      Eve::Star.pluck(:id).each do |star_id|
        Eve::UpdateStarJob.perform_later(star_id)
      end
    end
  end
end

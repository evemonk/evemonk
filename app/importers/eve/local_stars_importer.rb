# frozen_string_literal: true

# TODO: update
module Eve
  class LocalStarsImporter
    def import
      Eve::Star.pluck(:star_id).each do |star_id|
        Eve::UpdateStarJob.perform_later(star_id)
      end
    end
  end
end

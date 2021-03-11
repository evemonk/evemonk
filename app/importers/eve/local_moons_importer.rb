# frozen_string_literal: true

# TODO: update
module Eve
  class LocalMoonsImporter
    def import
      Eve::Moon.pluck(:planet_id, :moon_id).each do |planet_id, moon_id|
        Eve::UpdateMoonJob.perform_later(planet_id, moon_id)
      end
    end
  end
end

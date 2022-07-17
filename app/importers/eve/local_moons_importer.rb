# frozen_string_literal: true

module Eve
  class LocalMoonsImporter
    def import
      Eve::Moon.pluck(:planet_id, :id).each do |planet_id, moon_id|
        Eve::UpdateMoonJob.perform_later(planet_id, moon_id)
      end
    end
  end
end

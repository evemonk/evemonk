# frozen_string_literal: true

module Eve
  class LocalPlanetsImporter
    def import
      Eve::Planet.pluck(:id).each do |planet_id|
        Eve::UpdatePlanetJob.perform_later(planet_id)
      end
    end
  end
end

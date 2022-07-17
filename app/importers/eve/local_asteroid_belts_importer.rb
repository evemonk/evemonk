# frozen_string_literal: true

module Eve
  class LocalAsteroidBeltsImporter
    def import
      Eve::AsteroidBelt.pluck(:planet_id, :id).each do |planet_id, asteroid_belt_id|
        Eve::UpdateAsteroidBeltJob.perform_later(planet_id, asteroid_belt_id)
      end
    end
  end
end

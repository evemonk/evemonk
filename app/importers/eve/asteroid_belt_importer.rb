# frozen_string_literal: true

module Eve
  class AsteroidBeltImporter < BaseImporter
    attr_reader :planet_id, :asteroid_belt_id

    def initialize(planet_id, asteroid_belt_id)
      @planet_id = planet_id
      @asteroid_belt_id = asteroid_belt_id
    end

    def import
      import! do
        eve_asteroid_belt = Eve::AsteroidBelt.find_or_initialize_by(planet_id: planet_id,
          id: asteroid_belt_id)

        eve_asteroid_belt.update!(esi.as_json)

        eve_asteroid_belt.position&.destroy

        eve_asteroid_belt.create_position!(esi.position.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve AsteroidBelt ID #{planet_id}/#{asteroid_belt_id}")

        eve_asteroid_belt.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseAsteroidBelt.new(id: asteroid_belt_id)
    end
  end
end

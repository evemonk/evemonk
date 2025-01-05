# frozen_string_literal: true

module Eve
  class PlanetImporter < BaseImporter
    attr_reader :planet_id

    def initialize(planet_id)
      @planet_id = planet_id
    end

    def import
      import! do
        eve_planet = Eve::Planet.find_or_initialize_by(planet_id: planet_id)

        eve_planet.update!(esi.as_json)

        eve_planet.position&.destroy

        eve_planet.create_position!(esi.position.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Planet ID #{planet_id}")

        eve_planet.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniversePlanet.new(id: planet_id)
    end
  end
end

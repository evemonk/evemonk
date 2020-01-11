# frozen_string_literal: true

module Eve
  class PlanetImporter
    attr_reader :planet_id

    def initialize(planet_id)
      @planet_id = planet_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_planet = Eve::Planet.find_or_initialize_by(planet_id: planet_id)

        esi = EveOnline::ESI::UniversePlanet.new(id: planet_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_planet.update!(esi.as_json)

        eve_planet.position&.destroy

        eve_planet.create_position!(esi.position.as_json)

        etag.update!(etag: esi.etag, body: esi.response)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_planet.destroy!
      end
    end
  end
end

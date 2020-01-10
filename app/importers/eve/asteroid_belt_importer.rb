# frozen_string_literal: true

module Eve
  class AsteroidBeltImporter
    attr_reader :planet_id, :asteroid_belt_id

    def initialize(planet_id, asteroid_belt_id)
      @planet_id = planet_id
      @asteroid_belt_id = asteroid_belt_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_asteroid_belt = Eve::AsteroidBelt.find_or_initialize_by(planet_id: planet_id,
                                                                    asteroid_belt_id: asteroid_belt_id)

        esi = EveOnline::ESI::UniverseAsteroidBelt.new(id: asteroid_belt_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_asteroid_belt.update!(esi.as_json)

        eve_asteroid_belt.position&.destroy

        eve_asteroid_belt.create_position!(esi.position.as_json)

        etag.update!(etag: esi.etag, body: esi.response)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_asteroid_belt.destroy!
      end
    end
  end
end

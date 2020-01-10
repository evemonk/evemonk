# frozen_string_literal: true

module Eve
  class MoonImporter
    attr_reader :planet_id, :moon_id

    def initialize(planet_id, moon_id)
      @planet_id = planet_id
      @moon_id = moon_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_moon = Eve::Moon.find_or_initialize_by(planet_id: planet_id, moon_id: moon_id)

        esi = EveOnline::ESI::UniverseMoon.new(id: moon_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_moon.update!(esi.as_json)

        eve_moon.position&.destroy

        eve_moon.create_position!(esi.position.as_json)

        etag.update!(etag: esi.etag, body: esi.response)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_moon.destroy!
      end
    end
  end
end

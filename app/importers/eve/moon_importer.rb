# frozen_string_literal: true

module Eve
  class MoonImporter < BaseImporter
    attr_reader :planet_id, :moon_id

    def initialize(planet_id, moon_id)
      @planet_id = planet_id
      @moon_id = moon_id
    end

    def import!
      eve_moon = Eve::Moon.find_or_initialize_by(planet_id: planet_id, moon_id: moon_id)

      eve_moon.update!(esi.as_json)

      eve_moon.position&.destroy

      eve_moon.create_position!(esi.position.as_json)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_moon.destroy!
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseMoon.new(id: moon_id)
    end
  end
end

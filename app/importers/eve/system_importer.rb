# frozen_string_literal: true

module Eve
  class SystemImporter < BaseImporter
    attr_reader :system_id, :locale

    def initialize(system_id, locale = :en)
      @system_id = system_id
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          eve_system = Eve::System.find_or_initialize_by(system_id: system_id)

          eve_system.update!(esi.as_json)

          eve_system.position&.destroy

          eve_system.create_position!(esi.position.as_json)

          Eve::UpdateStarJob.perform_later(esi.star_id) if esi.star_id.present?

          esi.stargate_ids.each do |stargate_id|
            Eve::UpdateStargateJob.perform_later(stargate_id)
          end

          esi.station_ids.each do |station_id|
            Eve::UpdateStationJob.perform_later(station_id)
          end

          esi.planets.each do |planet|
            Eve::UpdatePlanetJob.perform_later(planet.planet_id)

            planet.asteroid_belt_ids.each do |asteroid_belt_id|
              Eve::UpdateAsteroidBeltJob.perform_later(planet.planet_id, asteroid_belt_id)
            end

            planet.moon_ids.each do |moon_id|
              Eve::UpdateMoonJob.perform_later(planet.planet_id, moon_id)
            end
          end
        rescue EveOnline::Exceptions::ResourceNotFound
          Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve System ID #{system_id}")

          eve_system.destroy!
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseSystem.new(id: system_id, language: LanguageMapper::LANGUAGES[locale])
    end
  end
end

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
          eve_system = Eve::System.find_or_initialize_by(id: system_id)

          eve_system.update!(esi.as_json)

          eve_system.position&.destroy

          eve_system.create_position!(esi.position.as_json)

          Eve::Star.find_or_create_by!(id: esi.star_id) if esi.star_id.present?

          esi.stargate_ids.each do |stargate_id|
            Eve::Stargate.find_or_create_by!(id: stargate_id)
          end

          esi.station_ids.each do |station_id|
            Eve::Station.find_or_create_by!(id: station_id)
          end

          esi.planets.each do |planet|
            Eve::Planet.find_or_create_by!(id: planet.planet_id)

            planet.asteroid_belt_ids.each do |asteroid_belt_id|
              Eve::AsteroidBelt.find_or_create_by!(id: asteroid_belt_id,
                planet_id: planet.planet_id)
            end

            planet.moon_ids.each do |moon_id|
              Eve::Moon.find_or_create_by!(id: moon_id, planet_id: planet.planet_id)
            end
          end
        rescue EveOnline::Exceptions::ResourceNotFound
          Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve System ID #{system_id}")

          eve_system.destroy!
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseSystem.new(system_id: system_id, language: LanguageMapper::LANGUAGES[locale])
    end
  end
end

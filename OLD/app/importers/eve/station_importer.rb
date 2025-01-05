# frozen_string_literal: true

module Eve
  class StationImporter < BaseImporter
    attr_reader :station_id

    def initialize(station_id)
      @station_id = station_id
    end

    def import
      import! do
        eve_station = Eve::Station.find_or_initialize_by(station_id: station_id)

        eve_station.update!(esi.as_json)

        eve_station.position&.destroy

        eve_station.create_position!(esi.position.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Station ID #{station_id}")

        eve_station.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseStation.new(id: station_id)
    end
  end
end

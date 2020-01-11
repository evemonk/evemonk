# frozen_string_literal: true

module Eve
  class StationImporter
    attr_reader :station_id

    def initialize(station_id)
      @station_id = station_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_station = Eve::Station.find_or_initialize_by(station_id: station_id)

        esi = EveOnline::ESI::UniverseStation.new(id: station_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_station.update!(esi.as_json)

        eve_station.position&.destroy

        eve_station.create_position!(esi.position.as_json)

        etag.update!(etag: esi.etag, body: esi.response)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_station.destroy!
      end
    end
  end
end

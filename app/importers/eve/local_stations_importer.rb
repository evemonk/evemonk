# frozen_string_literal: true

module Eve
  class LocalStationsImporter
    def import
      Eve::Station.pluck(:id).each do |station_id|
        Eve::UpdateStationJob.perform_later(station_id)
      end
    end
  end
end

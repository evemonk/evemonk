# frozen_string_literal: true

module ImportMissing
  class Stations
    def import
      Rails.logger.info "Import missing eve stations"

      station_ids.each do |station_id|
        Eve::UpdateStationJob.perform_later(station_id)
      end
    end

    private

    def station_ids
      Character.where.not(current_station_id: nil)
        .where.missing(:current_station)
        .pluck(:current_station_id)
        .sort
        .uniq
    end
  end
end

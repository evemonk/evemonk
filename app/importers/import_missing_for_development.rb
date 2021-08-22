# frozen_string_literal: true

class ImportMissingForDevelopment
  def import
    Rails.logger.info "Import eve systems"
    Character.where.not(current_solar_system_id: nil)
      .pluck(:current_solar_system_id)
      .sort
      .uniq
      .each do |system_id|
      Eve::UpdateSystemJob.perform_later(system_id)
    end

    Rails.logger.info "Import eve stations"
    Character.where.not(current_station_id: nil)
      .pluck(:current_station_id)
      .sort
      .uniq
      .each do |station_id|
      Eve::UpdateStationJob.perform_later(station_id)
    end
  end
end

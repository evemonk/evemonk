# frozen_string_literal: true

class ImportMissingForDevelopment
  def import
    Rails.logger.info "Import eve alliances"
    Character.where.not(alliance_id: nil)
      .pluck(:alliance_id)
      .sort
      .uniq
      .each do |alliance_id|
      Eve::UpdateAllianceJob.perform_later(alliance_id)
    end

    Rails.logger.info "Import eve corporations"
    Character.pluck(:corporation_id).sort.uniq.each do |corporation_id|
      Eve::UpdateCorporationJob.perform_later(corporation_id)
    end

    Rails.logger.info "Import eve ships"
    Character.where.not(current_ship_type_id: nil)
      .pluck(:current_ship_type_id)
      .sort
      .uniq
      .each do |type_id|
      Eve::UpdateTypeJob.perform_later(type_id)
    end

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

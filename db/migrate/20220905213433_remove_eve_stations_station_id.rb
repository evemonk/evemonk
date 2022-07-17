# frozen_string_literal: true

class RemoveEveStationsStationId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_stations, :station_id, unique: true
    remove_column :eve_stations, :station_id, :bigint
  end
end

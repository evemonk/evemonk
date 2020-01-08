# frozen_string_literal: true

class FixIndexEveStations < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_stations, :station_id
    add_index :eve_stations, :station_id, unique: true
  end
end

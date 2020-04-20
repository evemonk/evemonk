# frozen_string_literal: true

class AddIndexesEveStations < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_stations, :race_id
    add_index :eve_stations, :system_id
    add_index :eve_stations, :type_id
  end
end

# frozen_string_literal: true

class CreateEveStations < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_stations do |t|
      t.float :max_dockable_ship_volume
      t.string :name
      t.float :office_rental_cost
      t.bigint :owner
      t.bigint :race_id
      t.float :reprocessing_efficiency
      t.float :reprocessing_stations_take
      t.string :services, array: true
      t.bigint :station_id
      t.bigint :system_id
      t.bigint :type_id

      t.timestamps
    end

    add_index :eve_stations, :station_id
  end
end

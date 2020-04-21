# frozen_string_literal: true

class AddIndexesCharacters < ActiveRecord::Migration[6.0]
  def change
    add_index :characters, :current_solar_system_id
    add_index :characters, :current_station_id
    add_index :characters, :current_structure_id
    add_index :characters, :current_ship_item_id
    add_index :characters, :current_ship_type_id
  end
end

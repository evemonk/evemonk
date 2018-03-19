# frozen_string_literal: true

class CreateEveFactions < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_factions do |t|
      t.integer :faction_id
      t.string :name
      t.text :description
      t.integer :solar_system_id
      t.integer :corporation_id
      t.integer :militia_corporation_id
      t.float :size_factor
      t.integer :station_count
      t.integer :station_system_count
      t.boolean :is_unique

      t.timestamps
    end
  end
end

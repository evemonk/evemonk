# frozen_string_literal: true

class CreateEveFactionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_factions do |t|
      t.bigint :faction_id
      t.bigint :corporation_id
      t.text :description
      t.boolean :is_unique
      t.bigint :militia_corporation_id
      t.string :name
      t.float :size_factor
      t.bigint :solar_system_id
      t.integer :station_count
      t.integer :station_system_count
      t.timestamps
      t.index :faction_id, unique: true
    end
  end
end

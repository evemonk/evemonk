# frozen_string_literal: true

class CreateEveMoons < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_moons do |t|
      t.bigint :moon_id
      t.string :name
      t.bigint :system_id
      t.bigint :planet_id

      t.timestamps
    end

    add_index :eve_moons, :moon_id, unique: true
    add_index :eve_moons, :system_id
    add_index :eve_moons, :planet_id
  end
end

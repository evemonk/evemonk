# frozen_string_literal: true

class CreateEveAsteroidBelts < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_asteroid_belts do |t|
      t.bigint :asteroid_belt_id
      t.string :name
      t.bigint :system_id
      t.bigint :planet_id

      t.timestamps
    end

    add_index :eve_asteroid_belts, :asteroid_belt_id, unique: true
    add_index :eve_asteroid_belts, :system_id
    add_index :eve_asteroid_belts, :planet_id
  end
end

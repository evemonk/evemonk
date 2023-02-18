# frozen_string_literal: true

class RemoveEveAsteroidBeltsAsteroidBeltId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_asteroid_belts, :asteroid_belt_id, unique: true
    remove_column :eve_asteroid_belts, :asteroid_belt_id, :bigint
  end
end

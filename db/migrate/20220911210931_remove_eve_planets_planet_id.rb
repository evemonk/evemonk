# frozen_string_literal: true

class RemoveEvePlanetsPlanetId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_planets, :planet_id, unique: true
    remove_column :eve_planets, :planet_id, :bigint
  end
end

# frozen_string_literal: true

class AddIndexEvePlanetsPlanetId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_planets, :planet_id, unique: true
  end
end

# frozen_string_literal: true

class FixIndexEveConstellations < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_constellations, :constellation_id
    add_index :eve_constellations, :constellation_id, unique: true
  end
end

# frozen_string_literal: true

class RemoveEveConstellationsConstellationId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_constellations, :constellation_id, unique: true
    remove_column :eve_constellations, :constellation_id, :bigint
  end
end

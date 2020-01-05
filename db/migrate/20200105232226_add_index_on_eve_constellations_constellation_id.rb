# frozen_string_literal: true

class AddIndexOnEveConstellationsConstellationId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_constellations, :constellation_id
  end
end

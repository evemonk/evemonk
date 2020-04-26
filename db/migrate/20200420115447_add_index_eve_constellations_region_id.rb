# frozen_string_literal: true

class AddIndexEveConstellationsRegionId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_constellations, :region_id
  end
end

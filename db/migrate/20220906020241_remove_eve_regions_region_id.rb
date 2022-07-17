# frozen_string_literal: true

class RemoveEveRegionsRegionId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_regions, :region_id, unique: true
    remove_column :eve_regions, :region_id, :bigint
  end
end

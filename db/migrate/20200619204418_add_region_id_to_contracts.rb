# frozen_string_literal: true

class AddRegionIdToContracts < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_contracts, :region_id, :bigint
  end
end

# frozen_string_literal: true

class AddIsManufacturingItemToEveType < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :is_manufacturing_item, :boolean
  end
end

# frozen_string_literal: true

class RemoveEveUnitsUnitId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_units, :unit_id, unique: true
    remove_column :eve_units, :unit_id, :bigint
  end
end

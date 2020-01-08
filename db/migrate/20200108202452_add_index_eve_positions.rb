# frozen_string_literal: true

class AddIndexEvePositions < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_positions, [:positionable_id, :positionable_type], unique: true
  end
end

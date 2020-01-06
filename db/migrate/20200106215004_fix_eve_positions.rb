# frozen_string_literal: true

class FixEvePositions < ActiveRecord::Migration[6.0]
  def change
    remove_column :eve_positions, :x, :bigint
    remove_column :eve_positions, :y, :bigint
    remove_column :eve_positions, :z, :bigint
    add_column :eve_positions, :x, :string
    add_column :eve_positions, :y, :string
    add_column :eve_positions, :z, :string
  end
end

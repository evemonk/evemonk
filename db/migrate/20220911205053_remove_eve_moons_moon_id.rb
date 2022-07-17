# frozen_string_literal: true

class RemoveEveMoonsMoonId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_moons, :moon_id, unique: true
    remove_column :eve_moons, :moon_id, :bigint
  end
end

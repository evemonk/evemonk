# frozen_string_literal: true

class RemoveEveSystemsSystemId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_systems, :system_id, unique: true
    remove_column :eve_systems, :system_id, :bigint
  end
end

# frozen_string_literal: true

class RemoveEveFactionsFactionId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_factions, :faction_id, unique: true
    remove_column :eve_factions, :faction_id, :bigint
  end
end

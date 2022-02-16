# frozen_string_literal: true

class RemoveEveAlliancesAllianceId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_alliances, :alliance_id, unique: true
    remove_column :eve_alliances, :alliance_id, :bigint
  end
end

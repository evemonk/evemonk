# frozen_string_literal: true

class RenameEveAlliancesAllianceId < ActiveRecord::Migration[7.0]
  def change
    rename_column :eve_alliances, :alliance_id, :id
  end
end

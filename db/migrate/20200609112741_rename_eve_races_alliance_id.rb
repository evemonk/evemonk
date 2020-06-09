# frozen_string_literal: true

class RenameEveRacesAllianceId < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_races, :alliance_id, :faction_id
  end
end

# frozen_string_literal: true

class RemoveEveRacesRaceId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_races, :race_id, unique: true
    remove_column :eve_races, :race_id, :bigint
  end
end

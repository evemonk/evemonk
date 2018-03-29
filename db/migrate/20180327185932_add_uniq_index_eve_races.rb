# frozen_string_literal: true

class AddUniqIndexEveRaces < ActiveRecord::Migration[5.2]
  def change
    add_index :eve_races, :race_id, unique: true
  end
end

# frozen_string_literal: true

class AddUniqIndexEveFactions < ActiveRecord::Migration[5.2]
  def change
    add_index :eve_factions, :faction_id, unique: true
  end
end

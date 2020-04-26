# frozen_string_literal: true

class AddIndexesEveAlliances < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_alliances, :creator_corporation_id
    add_index :eve_alliances, :creator_id
    add_index :eve_alliances, :executor_corporation_id
    add_index :eve_alliances, :faction_id
    remove_index :eve_alliances, :name
  end
end

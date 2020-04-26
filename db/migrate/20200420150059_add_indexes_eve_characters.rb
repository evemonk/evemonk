# frozen_string_literal: true

class AddIndexesEveCharacters < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_characters, :ancestry_id
    add_index :eve_characters, :bloodline_id
    add_index :eve_characters, :faction_id
    add_index :eve_characters, :race_id
  end
end

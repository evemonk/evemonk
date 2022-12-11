# frozen_string_literal: true

class RemoveEveCharactersCharacterId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_characters, :character_id, unique: true
    remove_column :eve_characters, :character_id, :bigint
  end
end

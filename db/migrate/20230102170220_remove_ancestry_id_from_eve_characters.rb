# frozen_string_literal: true

class RemoveAncestryIdFromEveCharacters < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_characters, :ancestry_id
    remove_column :eve_characters, :ancestry_id, :bigint
  end
end

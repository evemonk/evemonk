# frozen_string_literal: true

class AddMissingIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_alliances, :name
    add_index :eve_corporations, :name
    add_index :eve_characters, :name
  end
end

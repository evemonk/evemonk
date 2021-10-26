# frozen_string_literal: true

class AddIndexEveCharactersNameGin < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_characters, :name

    add_index :eve_characters, :name, using: :gin, opclass: :gin_trgm_ops
  end
end

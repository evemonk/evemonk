# frozen_string_literal: true

class DropIndexEveCharactersOnName < ActiveRecord::Migration[8.1]
  def change
    remove_index :eve_characters, :name, name: :index_eve_characters_on_name, opclass: :gin_trgm_ops, using: :gin
  end
end

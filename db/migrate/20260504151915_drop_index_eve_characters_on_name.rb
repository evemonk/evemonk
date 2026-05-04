# frozen_string_literal: true

class DropIndexEveCharactersOnName < ActiveRecord::Migration[8.1]
  def change
    remove_index :eve_characters, name: :index_eve_characters_on_name
  end
end

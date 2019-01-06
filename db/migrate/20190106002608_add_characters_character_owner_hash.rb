# frozen_string_literal: true

class AddCharactersCharacterOwnerHash < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :character_owner_hash, :string
  end
end

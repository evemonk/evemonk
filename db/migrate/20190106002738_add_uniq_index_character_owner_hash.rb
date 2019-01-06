# frozen_string_literal: true

class AddUniqIndexCharacterOwnerHash < ActiveRecord::Migration[6.0]
  def change
    add_index :characters, :character_owner_hash, unique: true
  end
end

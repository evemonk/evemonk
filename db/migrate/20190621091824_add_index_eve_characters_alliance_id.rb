# frozen_string_literal: true

class AddIndexEveCharactersAllianceId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_characters, :alliance_id
  end
end

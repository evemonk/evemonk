# frozen_string_literal: true

class AddIndexEveCharactersCorporationId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_characters, :corporation_id
  end
end

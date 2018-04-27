# frozen_string_literal: true

class AddIndexCharactersCorporationId < ActiveRecord::Migration[5.2]
  def change
    add_index :characters, :corporation_id
  end
end

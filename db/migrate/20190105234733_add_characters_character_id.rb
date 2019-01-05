# frozen_string_literal: true

class AddCharactersCharacterId < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :character_id, :bigint
  end
end

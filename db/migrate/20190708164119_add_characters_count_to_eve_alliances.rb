# frozen_string_literal: true

class AddCharactersCountToEveAlliances < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_alliances, :characters_count, :bigint, default: 0
  end
end

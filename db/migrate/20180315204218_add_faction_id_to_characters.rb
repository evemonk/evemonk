# frozen_string_literal: true

class AddFactionIdToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :faction_id, :integer
  end
end

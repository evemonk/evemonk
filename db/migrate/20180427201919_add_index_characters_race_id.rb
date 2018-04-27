# frozen_string_literal: true

class AddIndexCharactersRaceId < ActiveRecord::Migration[5.2]
  def change
    add_index :characters, :race_id
  end
end

# frozen_string_literal: true

class AddIndexCharactersAllianceId < ActiveRecord::Migration[5.2]
  def change
    add_index :characters, :alliance_id
  end
end

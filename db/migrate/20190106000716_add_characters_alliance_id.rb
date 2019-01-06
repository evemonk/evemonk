# frozen_string_literal: true

class AddCharactersAllianceId < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :alliance_id, :bigint
    add_index :characters, :alliance_id
  end
end

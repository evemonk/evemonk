# frozen_string_literal: true

class RemoveCharactersAllianceId < ActiveRecord::Migration[6.0]
  def change
    remove_index :characters, :alliance_id
    remove_column :characters, :alliance_id, :integer
  end
end

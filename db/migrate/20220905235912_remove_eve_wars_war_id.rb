# frozen_string_literal: true

class RemoveEveWarsWarId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_wars, :war_id, unique: true
    remove_column :eve_wars, :war_id, :bigint
  end
end

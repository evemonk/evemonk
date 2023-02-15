# frozen_string_literal: true

class RemoveEveAncestriesAncestryId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_ancestries, :ancestry_id, unique: true
    remove_column :eve_ancestries, :ancestry_id, :bigint
  end
end

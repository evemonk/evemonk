# frozen_string_literal: true

class RemoveAncestryIdFromCharacters < ActiveRecord::Migration[7.0]
  def change
    remove_index :characters, :ancestry_id
    remove_column :characters, :ancestry_id, :bigint
  end
end

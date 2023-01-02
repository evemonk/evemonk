# frozen_string_literal: true

class RemoveAncestryIdFromCharacters < ActiveRecord::Migration[7.0]
  def change
    remove_column :characters, :ancestry_id, :bigint
  end
end

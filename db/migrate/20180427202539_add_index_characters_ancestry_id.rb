# frozen_string_literal: true

class AddIndexCharactersAncestryId < ActiveRecord::Migration[5.2]
  def change
    add_index :characters, :ancestry_id
  end
end

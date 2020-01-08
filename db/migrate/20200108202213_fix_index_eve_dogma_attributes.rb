# frozen_string_literal: true

class FixIndexEveDogmaAttributes < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_dogma_attributes, :attribute_id
    add_index :eve_dogma_attributes, :attribute_id, unique: true
  end
end

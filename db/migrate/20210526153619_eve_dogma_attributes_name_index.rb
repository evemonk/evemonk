# frozen_string_literal: true

class EveDogmaAttributesNameIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :eve_dogma_attributes, :name
  end
end

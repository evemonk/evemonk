# frozen_string_literal: true

class AddIndexEveDogmaAttributesAttributeId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_dogma_attributes, :attribute_id
  end
end

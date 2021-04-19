# frozen_string_literal: true

class EveTypeDogmaAttributesAttributeId < ActiveRecord::Migration[6.1]
  def change
    add_index :eve_type_dogma_attributes, :attribute_id
  end
end

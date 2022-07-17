# frozen_string_literal: true

class RemoveEveCharacterAttributesAttributeId < ActiveRecord::Migration[7.0]
  def change
    remove_column :eve_character_attributes, :attribute_id, :integer
  end
end

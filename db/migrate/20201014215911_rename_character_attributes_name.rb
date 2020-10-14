# frozen_string_literal: true

class RenameCharacterAttributesName < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_character_attributes, :attribute_name, :name_en
  end
end

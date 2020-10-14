# frozen_string_literal: true

class AddCharacterAttributesNameTranslations < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_character_attributes, :name_de, :string
    add_column :eve_character_attributes, :name_fr, :string
    add_column :eve_character_attributes, :name_ja, :string
    add_column :eve_character_attributes, :name_ru, :string
    add_column :eve_character_attributes, :name_zh, :string
    add_column :eve_character_attributes, :name_ko, :string
  end
end

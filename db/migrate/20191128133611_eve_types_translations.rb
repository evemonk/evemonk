# frozen_string_literal: true

class EveTypesTranslations < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_types, :name, :name_en
    add_column :eve_types, :name_de, :string
    add_column :eve_types, :name_fr, :string
    add_column :eve_types, :name_ja, :string
    add_column :eve_types, :name_ru, :string
    add_column :eve_types, :name_zh, :string
    add_column :eve_types, :name_ko, :string
  end
end

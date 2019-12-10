# frozen_string_literal: true

class AddEveSystemsTranslations < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_systems, :name, :name_en
    add_column :eve_systems, :name_de, :string
    add_column :eve_systems, :name_fr, :string
    add_column :eve_systems, :name_ja, :string
    add_column :eve_systems, :name_ru, :string
    add_column :eve_systems, :name_zh, :string
    add_column :eve_systems, :name_ko, :string
  end
end

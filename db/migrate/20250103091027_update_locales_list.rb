# frozen_string_literal: true

class UpdateLocalesList < ActiveRecord::Migration[8.0]
  def change
    add_column :eve_categories, :name_zh, :string
    add_column :eve_categories, :name_es, :string
    remove_column :eve_factions, :name_ru, :string
    remove_column :eve_factions, :description_ru, :text
    add_column :eve_factions, :name_zh, :string
    add_column :eve_factions, :name_es, :string
    add_column :eve_factions, :description_zh, :text
    add_column :eve_factions, :description_es, :text
  end
end

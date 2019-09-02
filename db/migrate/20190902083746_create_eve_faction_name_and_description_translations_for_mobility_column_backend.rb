# frozen_string_literal: true

class CreateEveFactionNameAndDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_factions, :name, :name_en
    add_column :eve_factions, :name_de, :string
    add_column :eve_factions, :name_fr, :string
    add_column :eve_factions, :name_ja, :string
    add_column :eve_factions, :name_ru, :string
    add_column :eve_factions, :name_zh, :string
    rename_column :eve_factions, :description, :description_en
    add_column :eve_factions, :description_de, :text
    add_column :eve_factions, :description_fr, :text
    add_column :eve_factions, :description_ja, :text
    add_column :eve_factions, :description_ru, :text
    add_column :eve_factions, :description_zh, :text
  end
end

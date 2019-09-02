# frozen_string_literal: true

class CreateEveAncestryNameAndDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_ancestries, :name, :name_en
    add_column :eve_ancestries, :name_de, :string
    add_column :eve_ancestries, :name_fr, :string
    add_column :eve_ancestries, :name_ja, :string
    add_column :eve_ancestries, :name_ru, :string
    add_column :eve_ancestries, :name_zh, :string
    rename_column :eve_ancestries, :description, :description_en
    add_column :eve_ancestries, :description_de, :text
    add_column :eve_ancestries, :description_fr, :text
    add_column :eve_ancestries, :description_ja, :text
    add_column :eve_ancestries, :description_ru, :text
    add_column :eve_ancestries, :description_zh, :text
  end
end

# frozen_string_literal: true

class CreateEveRaceNameAndDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_races, :name, :name_en
    add_column :eve_races, :name_de, :string
    add_column :eve_races, :name_fr, :string
    add_column :eve_races, :name_ja, :string
    add_column :eve_races, :name_ru, :string
    add_column :eve_races, :name_zh, :string
    rename_column :eve_races, :description, :description_en
    add_column :eve_races, :description_de, :text
    add_column :eve_races, :description_fr, :text
    add_column :eve_races, :description_ja, :text
    add_column :eve_races, :description_ru, :text
    add_column :eve_races, :description_zh, :text
  end
end

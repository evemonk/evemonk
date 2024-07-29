# frozen_string_literal: true

class RemoveRuLocale < ActiveRecord::Migration[7.2]
  def change
    remove_column :eve_ancestries, :name_ru, :string
    remove_column :eve_ancestries, :description_ru, :text

    remove_column :eve_bloodlines, :name_ru, :string
    remove_column :eve_bloodlines, :description_ru, :text

    remove_column :eve_categories, :name_ru, :string

    remove_column :eve_character_attributes, :name_ru, :string

    remove_column :eve_constellations, :name_ru, :string

    remove_column :eve_divisions, :description_full_ru, :text

    remove_column :eve_divisions, :leader_type_name_ru, :string

    remove_column :eve_divisions, :name_ru, :string

    remove_column :eve_factions, :name_ru, :string
    remove_column :eve_factions, :description_ru, :text

    remove_column :eve_groups, :name_ru, :string

    remove_column :eve_market_groups, :description_ru, :text
    remove_column :eve_market_groups, :name_ru, :string

    remove_column :eve_races, :name_ru, :string
    remove_column :eve_races, :description_ru, :text

    remove_column :eve_regions, :name_ru, :string
    remove_column :eve_regions, :description_ru, :text

    remove_column :eve_systems, :name_ru, :string

    remove_column :eve_types, :description_ru, :text
    remove_column :eve_types, :name_ru, :string
  end
end

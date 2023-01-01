# frozen_string_literal: true

class DropZhLanguage < ActiveRecord::Migration[6.0]
  def change
    remove_column :eve_ancestries, :name_zh, :string
    remove_column :eve_ancestries, :description_zh, :text
    remove_column :eve_bloodlines, :name_zh, :string
    remove_column :eve_bloodlines, :description_zh, :text
    remove_column :eve_categories, :name_zh, :string
    remove_column :eve_character_attributes, :name_zh, :string
    remove_column :eve_constellations, :name_zh, :string
    remove_column :eve_factions, :name_zh, :string
    remove_column :eve_factions, :description_zh, :text
    remove_column :eve_groups, :name_zh, :string
    remove_column :eve_market_groups, :description_zh, :text
    remove_column :eve_market_groups, :name_zh, :string
    remove_column :eve_races, :description_zh, :text
    remove_column :eve_races, :name_zh, :string
    remove_column :eve_regions, :description_zh, :text
    remove_column :eve_regions, :name_zh, :string
    remove_column :eve_systems, :name_zh, :string
    remove_column :eve_types, :description_zh, :text
    remove_column :eve_types, :name_zh, :string
  end
end

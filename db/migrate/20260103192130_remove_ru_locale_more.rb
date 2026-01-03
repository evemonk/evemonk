# frozen_string_literal: true

class RemoveRuLocaleMore < ActiveRecord::Migration[8.1]
  def change
    remove_column :eve_character_attributes, :name_ru, :string

    remove_column :eve_constellations, :name_ru, :string

    remove_column :eve_divisions, :description_full_ru, :text

    remove_column :eve_divisions, :leader_type_name_ru, :string

    remove_column :eve_divisions, :name_ru, :string

    remove_column :eve_market_groups, :description_ru, :text

    remove_column :eve_market_groups, :name_ru, :string

    remove_column :eve_regions, :description_ru, :text

    remove_column :eve_regions, :name_ru, :string

    remove_column :eve_systems, :name_ru, :string

    remove_column :eve_types, :description_ru, :text

    remove_column :eve_types, :name_ru, :string
  end
end

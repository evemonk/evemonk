# frozen_string_literal: true

class DropRuLocaleFromRaces < ActiveRecord::Migration[8.0]
  def change
    remove_column :eve_races, :name_ru, :string
    remove_column :eve_races, :description_ru, :text
  end
end

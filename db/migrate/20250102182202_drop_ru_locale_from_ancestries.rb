# frozen_string_literal: true

class DropRuLocaleFromAncestries < ActiveRecord::Migration[8.0]
  def change
    remove_column :eve_ancestries, :name_ru, :string
    remove_column :eve_ancestries, :description_ru, :text
  end
end

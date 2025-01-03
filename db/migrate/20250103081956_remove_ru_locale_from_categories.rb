# frozen_string_literal: true

class RemoveRuLocaleFromCategories < ActiveRecord::Migration[8.0]
  def change
    remove_column :eve_categories, :name_ru, :string
  end
end

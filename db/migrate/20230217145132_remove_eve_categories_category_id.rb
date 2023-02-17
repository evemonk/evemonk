# frozen_string_literal: true

class RemoveEveCategoriesCategoryId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_categories, :category_id, unique: true
    remove_column :eve_categories, :category_id, :bigint
  end
end

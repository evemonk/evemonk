# frozen_string_literal: true

class AddIndexEveCategoriesCategoryId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_categories, :category_id, unique: true
  end
end

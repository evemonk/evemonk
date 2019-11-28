# frozen_string_literal: true

class AddNameKoToEveCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_categories, :name_ko, :string
  end
end

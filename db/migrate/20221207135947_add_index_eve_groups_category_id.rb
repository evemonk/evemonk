# frozen_string_literal: true

class AddIndexEveGroupsCategoryId < ActiveRecord::Migration[7.0]
  def change
    add_index :eve_groups, :category_id
  end
end

# frozen_string_literal: true

class DropRuLocaleFromBloodlines < ActiveRecord::Migration[8.0]
  def change
    remove_column :eve_bloodlines, :name_ru, :string
    remove_column :eve_bloodlines, :description_ru, :string
  end
end

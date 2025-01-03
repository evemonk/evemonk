# frozen_string_literal: true

class UpdateEveGroupsLocales < ActiveRecord::Migration[8.0]
  def change
    remove_column :eve_groups, :name_ru, :string
    add_column :eve_groups, :name_zh, :string
    add_column :eve_groups, :name_es, :string
  end
end

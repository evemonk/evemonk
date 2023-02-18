# frozen_string_literal: true

class RemoveEveIconsIconId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_icons, :icon_id, unique: true
    remove_column :eve_icons, :icon_id, :bigint
  end
end

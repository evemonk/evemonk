# frozen_string_literal: true

class AddIndexEveIcons < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_icons, :icon_id, unique: true
  end
end

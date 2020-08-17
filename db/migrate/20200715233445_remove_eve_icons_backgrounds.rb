# frozen_string_literal: true

class RemoveEveIconsBackgrounds < ActiveRecord::Migration[6.0]
  def change
    remove_column :eve_icons, :backgrounds
  end
end

# frozen_string_literal: true

class RemoveEveIconsForegrounds < ActiveRecord::Migration[6.0]
  def change
    remove_column :eve_icons, :foregrounds
  end
end

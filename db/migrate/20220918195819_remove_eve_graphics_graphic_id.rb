# frozen_string_literal: true

class RemoveEveGraphicsGraphicId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_graphics, :graphic_id, unique: true
    remove_column :eve_graphics, :graphic_id, :bigint
  end
end

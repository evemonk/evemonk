# frozen_string_literal: true

class RemoveCharacterPortraits < ActiveRecord::Migration[5.2]
  def change
    remove_column :characters, :portrait_small, :string
    remove_column :characters, :portrait_medium, :string
    remove_column :characters, :portrait_large, :string
    remove_column :characters, :portrait_huge, :string
  end
end

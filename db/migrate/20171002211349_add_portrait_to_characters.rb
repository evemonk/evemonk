# frozen_string_literal: true

class AddPortraitToCharacters < ActiveRecord::Migration[5.1]
  def change
    change_table :characters, bulk: true do |t|
      t.string :portrait_small
      t.string :portrait_medium
      t.string :portrait_large
      t.string :portrait_huge
    end
  end
end

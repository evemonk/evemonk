# frozen_string_literal: true

class AddAttributesToCharacters < ActiveRecord::Migration[5.1]
  def change
    change_table :characters, bulk: true do |t|
      t.integer :charisma
      t.integer :intelligence
      t.integer :memory
      t.integer :perception
      t.integer :willpower
      t.integer :bonus_remaps
      t.datetime :last_remap_date
      t.datetime :accrued_remap_cooldown_date
    end
  end
end

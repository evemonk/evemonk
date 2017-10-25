# frozen_string_literal: true

class AddAttributesToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :charisma, :integer
    add_column :characters, :intelligence, :integer
    add_column :characters, :memory, :integer
    add_column :characters, :perception, :integer
    add_column :characters, :willpower, :integer
    add_column :characters, :bonus_remaps, :integer
    add_column :characters, :last_remap_date, :datetime
    add_column :characters, :accrued_remap_cooldown_date, :datetime
  end
end

# frozen_string_literal: true

class AddIndexesEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_types, :group_id
    add_index :eve_types, :market_group_id
    add_index :eve_types, :graphic_id
    add_index :eve_types, :icon_id
  end
end

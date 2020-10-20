# frozen_string_literal: true

class AddIndexEveCorporationsNpc < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_corporations, [:npc, :member_count]
  end
end

# frozen_string_literal: true

class RemoveUnusedIndexLpOnCharacterId < ActiveRecord::Migration[6.0]
  def change
    remove_index :loyalty_points, :character_id
  end
end

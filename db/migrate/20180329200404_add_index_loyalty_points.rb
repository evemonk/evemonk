# frozen_string_literal: true

class AddIndexLoyaltyPoints < ActiveRecord::Migration[5.2]
  def change
    add_index :loyalty_points, :character_id

    add_index :loyalty_points, [:character_id, :corporation_id], unique: true
  end
end

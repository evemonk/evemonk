# frozen_string_literal: true

class CreateLoyaltyPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :loyalty_points do |t|
      t.bigint :character_id
      t.integer :corporation_id
      t.integer :loyalty_points

      t.timestamps
    end
  end
end

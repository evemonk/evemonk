# frozen_string_literal: true

class IntToBigintLoyaltyPoints < ActiveRecord::Migration[6.0]
  def change
    change_column :loyalty_points, :corporation_id, :bigint
  end
end

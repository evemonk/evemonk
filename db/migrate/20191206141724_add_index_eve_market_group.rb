# frozen_string_literal: true

class AddIndexEveMarketGroup < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_market_groups, :market_group_id, unique: true
  end
end

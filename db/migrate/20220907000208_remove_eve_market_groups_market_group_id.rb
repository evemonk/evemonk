# frozen_string_literal: true

class RemoveEveMarketGroupsMarketGroupId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_market_groups, :market_group_id, unique: true
    remove_column :eve_market_groups, :market_group_id, :bigint
  end
end

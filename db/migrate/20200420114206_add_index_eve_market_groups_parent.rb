# frozen_string_literal: true

class AddIndexEveMarketGroupsParent < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_market_groups, :parent_group_id
  end
end

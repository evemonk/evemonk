# frozen_string_literal: true

class AddAncestryToEveMarketGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :eve_market_groups, :ancestry, :string
    add_index :eve_market_groups, :ancestry
  end
end

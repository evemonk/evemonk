# frozen_string_literal: true

class AddIconIdToEveMarketGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :eve_market_groups, :icon_id, :bigint
  end
end

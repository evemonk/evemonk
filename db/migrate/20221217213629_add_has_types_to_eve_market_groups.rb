# frozen_string_literal: true

class AddHasTypesToEveMarketGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :eve_market_groups, :has_types, :boolean
  end
end

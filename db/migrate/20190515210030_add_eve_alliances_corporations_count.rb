# frozen_string_literal: true

class AddEveAlliancesCorporationsCount < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_alliances, :corporations_count, :integer, default: 0
  end
end

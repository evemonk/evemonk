# frozen_string_literal: true

class RemoveEveAlliancesId < ActiveRecord::Migration[7.0]
  def change
    remove_column :eve_alliances, :id
  end
end

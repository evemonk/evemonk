# frozen_string_literal: true

class DropIndexEveAlliancesOnNameAndTicker < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    remove_index :eve_alliances, [:name, :ticker], name: "index_eve_alliances_on_name_and_ticker", opclass: :gin_trgm_ops, using: :gin, algorithm: :concurrently
  end
end

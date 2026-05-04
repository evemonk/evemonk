# frozen_string_literal: true

class DropIndexEveCorporationsOnNameAndTicker < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    remove_index :eve_corporations, [:name, :ticker], name: "index_eve_corporations_on_name_and_ticker", opclass: :gin_trgm_ops, using: :gin, algorithm: :concurrently
  end
end

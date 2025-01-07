# frozen_string_literal: true

class AddMissingIndexesForAlliances < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :eve_alliances, :name, algorithm: :concurrently
  end
end

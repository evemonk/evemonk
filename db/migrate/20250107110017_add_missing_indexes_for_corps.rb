# frozen_string_literal: true

class AddMissingIndexesForCorps < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :eve_corporations, :name, algorithm: :concurrently
  end
end

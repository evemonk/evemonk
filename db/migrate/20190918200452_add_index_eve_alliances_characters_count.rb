# frozen_string_literal: true

class AddIndexEveAlliancesCharactersCount < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :eve_alliances, :characters_count, algorithm: :concurrently
  end
end

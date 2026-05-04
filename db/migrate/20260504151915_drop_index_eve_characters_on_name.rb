# frozen_string_literal: true

class DropIndexEveCharactersOnName < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    remove_index :eve_characters, :name, name: :index_eve_characters_on_name, opclass: :gin_trgm_ops, using: :gin, algorithm: :concurrently
  end
end

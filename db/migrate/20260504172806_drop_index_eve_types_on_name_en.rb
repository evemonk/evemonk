# frozen_string_literal: true

class DropIndexEveTypesOnNameEn < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    remove_index :eve_types, :name_en, name: "index_eve_types_on_name_en", opclass: :gin_trgm_ops, using: :gin, algorithm: :concurrently
  end
end

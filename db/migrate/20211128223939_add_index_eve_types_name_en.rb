# frozen_string_literal: true

class AddIndexEveTypesNameEn < ActiveRecord::Migration[7.0]
  def change
    add_index :eve_types, :name_en, using: :gin, opclass: :gin_trgm_ops, name: "index_eve_types_on_name_en"
  end
end

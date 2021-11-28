# frozen_string_literal: true

class RemoveIndexEveTypesNames < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_types, [:name_en, :name_de, :name_fr, :name_ja, :name_ko, :name_ru], using: :gin, opclass: :gin_trgm_ops, name: "index_eve_types_on_names"
  end
end

# frozen_string_literal: true

class AddIndexEveCorporationsNameGin < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_corporations, :name

    add_index :eve_corporations, [:name, :ticker], using: :gin, opclass: :gin_trgm_ops
  end
end

# frozen_string_literal: true

class AddIndexEveAlliancesNameGin < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_alliances, :name

    add_index :eve_alliances, [:name, :ticker], using: :gin, opclass: :gin_trgm_ops
  end
end

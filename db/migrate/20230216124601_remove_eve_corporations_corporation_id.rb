# frozen_string_literal: true

class RemoveEveCorporationsCorporationId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_corporations, :corporation_id, unique: true
    remove_column :eve_corporations, :corporation_id, :bigint
  end
end

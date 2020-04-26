# frozen_string_literal: true

class RemoveIndexCorporationName < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_corporations, :name
  end
end

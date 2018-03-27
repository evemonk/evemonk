# frozen_string_literal: true

class AddCorporationIdToEveCorporations < ActiveRecord::Migration[5.2]
  def change
    add_column :eve_corporations, :corporation_id, :integer
  end
end

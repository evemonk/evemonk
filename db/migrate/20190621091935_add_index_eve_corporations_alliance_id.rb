# frozen_string_literal: true

class AddIndexEveCorporationsAllianceId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_corporations, :alliance_id
  end
end

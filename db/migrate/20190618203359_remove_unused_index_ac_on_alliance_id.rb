# frozen_string_literal: true

class RemoveUnusedIndexAcOnAllianceId < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_alliance_corporations, :alliance_id
  end
end

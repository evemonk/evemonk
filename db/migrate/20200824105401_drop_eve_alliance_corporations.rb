# frozen_string_literal: true

class DropEveAllianceCorporations < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_alliance_corporations, column: [:alliance_id, :corporation_id], unique: true, name: :index_eve_ac_on_alliance_id_and_corporation_id
    remove_index :eve_alliance_corporations, :corporation_id

    drop_table :eve_alliance_corporations
  end
end

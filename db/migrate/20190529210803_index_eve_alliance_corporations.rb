# frozen_string_literal: true

class IndexEveAllianceCorporations < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_alliance_corporations, [:alliance_id, :corporation_id], unique: true, name: :index_eve_ac_on_alliance_id_and_corporation_id
  end
end

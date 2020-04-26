# frozen_string_literal: true

class AddIndexesEveCorporationAllianceHistories < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_corporation_alliance_histories, :corporation_id
    add_index :eve_corporation_alliance_histories, :alliance_id
  end
end

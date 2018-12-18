# frozen_string_literal: true

class CreateEveAlliancesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_alliances do |t|
      t.bigint :alliance_id
      t.bigint :creator_corporation_id
      t.bigint :creator_id
      t.datetime :date_founded
      t.bigint :executor_corporation_id
      t.bigint :faction_id
      t.string :name
      t.string :ticker
      t.timestamps
      t.index [:alliance_id], name: 'index_eve_alliances_on_alliance_id', unique: true
    end
  end
end

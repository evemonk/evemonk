# frozen_string_literal: true

class CreateEveCorporationAllianceHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_corporation_alliance_histories do |t|
      t.bigint :corporation_id
      t.bigint :alliance_id
      t.boolean :is_deleted
      t.bigint :record_id
      t.datetime :start_date

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateEveCharacterCorporationHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_character_corporation_histories do |t|
      t.bigint :character_id, null: false, foreign_key: true
      t.bigint :corporation_id, foreign_key: true
      t.boolean :is_deleted
      t.bigint :record_id
      t.datetime :start_date

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateCharacterCorporationHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :character_corporation_histories do |t|
      t.bigint :character_id
      t.bigint :corporation_id
      t.boolean :is_deleted
      t.bigint :record_id
      t.datetime :start_date

      t.timestamps
    end

    add_index :character_corporation_histories, [:character_id, :corporation_id], name: "index_char_corp_histories_on_char_id_and_corp_id"
    add_index :character_corporation_histories, :corporation_id
    add_index :character_corporation_histories, :record_id
  end
end

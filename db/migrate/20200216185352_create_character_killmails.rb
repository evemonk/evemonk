# frozen_string_literal: true

class CreateCharacterKillmails < ActiveRecord::Migration[6.0]
  def change
    create_table :character_killmails do |t|
      t.references :character, null: false, foreign_key: true
      t.string :killmail_hash
      t.bigint :killmail_id

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class RecreateCharacterScopes < ActiveRecord::Migration[7.0]
  def change
    create_table :character_scopes do |t|
      t.references :character, null: false, foreign_key: true
      t.string :access_token
      t.string :refresh_token
      t.datetime :token_expires_at, precision: nil
      t.boolean :token_expires
      t.string :token_type
      t.string :scope, null: false
      t.boolean :esi_token_valid, default: true
      t.datetime :esi_token_invalid_at, precision: nil
      t.text :esi_last_error

      t.timestamps
    end
  end
end

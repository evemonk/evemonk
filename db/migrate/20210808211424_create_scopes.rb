# frozen_string_literal: true

class CreateScopes < ActiveRecord::Migration[6.1]
  def change
    create_table :scopes, id: :uuid do |t|
      t.references :character, null: false, foreign_key: true
      t.string :access_token
      t.string :refresh_token
      t.datetime :token_expires_at
      t.boolean :token_expires
      t.string :token_type

      t.timestamps
    end
  end
end

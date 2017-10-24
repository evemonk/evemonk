# frozen_string_literal: true

class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.references :user, foreign_key: true
      t.integer :uid
      t.string :name
      t.string :token
      t.string :refresh_token
      t.datetime :token_expires_at
      t.boolean :token_expires
      t.string :scopes
      t.string :token_type

      t.timestamps
    end
  end
end

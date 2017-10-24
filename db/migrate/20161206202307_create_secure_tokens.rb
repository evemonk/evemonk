# frozen_string_literal: true

class CreateSecureTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :secure_tokens do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end

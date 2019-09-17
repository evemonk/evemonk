# frozen_string_literal: true

class AddForeignKeySecureTokensUsers < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :secure_tokens, :users
  end
end

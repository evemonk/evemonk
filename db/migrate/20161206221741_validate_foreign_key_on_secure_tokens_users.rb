# frozen_string_literal: true

class ValidateForeignKeyOnSecureTokensUsers < ActiveRecord::Migration[6.0]
  def change
    validate_foreign_key :secure_tokens, :users
  end
end

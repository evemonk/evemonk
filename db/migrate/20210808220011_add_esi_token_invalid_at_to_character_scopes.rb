# frozen_string_literal: true

class AddEsiTokenInvalidAtToCharacterScopes < ActiveRecord::Migration[6.1]
  def change
    add_column :character_scopes, :esi_token_invalid_at, :datetime
  end
end

# frozen_string_literal: true

class DropEsiTokensFromCharacters < ActiveRecord::Migration[8.1]
  def change
    remove_column :characters, :access_token, :string
    remove_column :characters, :refresh_token, :string
    remove_column :characters, :token_expires_at, :datetime, precision: nil
    remove_column :characters, :token_expires, :boolean
    remove_column :characters, :scopes, :text
    remove_column :characters, :token_type, :string
    remove_column :characters, :esi_token_valid, :boolean, default: true
    remove_column :characters, :esi_token_invalid_at, :datetime, precision: nil
    remove_column :characters, :esi_last_error, :text
  end
end

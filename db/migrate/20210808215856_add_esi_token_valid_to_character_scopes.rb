# frozen_string_literal: true

class AddEsiTokenValidToCharacterScopes < ActiveRecord::Migration[6.1]
  def change
    add_column :character_scopes, :esi_token_valid, :boolean, default: true
  end
end

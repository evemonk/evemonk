# frozen_string_literal: true

class AddEsiLastErrorToCharacterScopes < ActiveRecord::Migration[6.1]
  def change
    add_column :character_scopes, :esi_last_error, :text
  end
end

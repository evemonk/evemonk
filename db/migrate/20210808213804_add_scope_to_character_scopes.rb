# frozen_string_literal: true

class AddScopeToCharacterScopes < ActiveRecord::Migration[6.1]
  def change
    add_column :character_scopes, :scope, :string, null: false
  end
end

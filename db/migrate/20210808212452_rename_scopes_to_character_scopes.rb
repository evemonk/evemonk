# frozen_string_literal: true

class RenameScopesToCharacterScopes < ActiveRecord::Migration[6.1]
  def change
    rename_table :scopes, :character_scopes
  end
end

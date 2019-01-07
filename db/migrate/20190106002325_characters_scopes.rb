# frozen_string_literal: true

class CharactersScopes < ActiveRecord::Migration[6.0]
  def change
    remove_column :characters, :scopes, :string
    add_column :characters, :scopes, :text
  end
end

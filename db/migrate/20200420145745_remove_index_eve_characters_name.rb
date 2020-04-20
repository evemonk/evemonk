# frozen_string_literal: true

class RemoveIndexEveCharactersName < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_characters, :name
  end
end

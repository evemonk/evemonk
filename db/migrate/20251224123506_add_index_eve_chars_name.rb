# frozen_string_literal: true

class AddIndexEveCharsName < ActiveRecord::Migration[8.1]
  def change
    add_index :eve_characters, :name, algorithm: :concurrently
  end
end

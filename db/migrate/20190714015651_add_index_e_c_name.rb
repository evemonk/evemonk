# frozen_string_literal: true

class AddIndexECName < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_characters, :name
  end
end

# frozen_string_literal: true

class AddEveCharactersTitle < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_characters, :title, :string
  end
end

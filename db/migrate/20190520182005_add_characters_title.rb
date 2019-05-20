# frozen_string_literal: true

class AddCharactersTitle < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :title, :string
  end
end

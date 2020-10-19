# frozen_string_literal: true

class AddCharactersOnline < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :online, :boolean
  end
end

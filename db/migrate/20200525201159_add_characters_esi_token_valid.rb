# frozen_string_literal: true

class AddCharactersEsiTokenValid < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :esi_token_valid, :boolean, default: true
    add_column :characters, :esi_token_invalid_at, :datetime
    add_column :characters, :esi_last_error, :text
  end
end

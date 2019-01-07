# frozen_string_literal: true

class RenameCharactersTokenToAccessToken < ActiveRecord::Migration[6.0]
  def change
    rename_column :characters, :token, :access_token
  end
end

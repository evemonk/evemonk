# frozen_string_literal: true

class AddNameToSecureToken < ActiveRecord::Migration[5.0]
  def change
    add_column :secure_tokens, :name, :string
  end
end

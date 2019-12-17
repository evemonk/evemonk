# frozen_string_literal: true

class DropSorceryPasswordAndSalt < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :crypted_password, :string
    remove_column :users, :salt, :string
  end
end

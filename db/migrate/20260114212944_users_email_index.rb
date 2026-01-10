# frozen_string_literal: true

class UsersEmailIndex < ActiveRecord::Migration[8.1]
  def change
    add_index :users, :email_address, unique: true
  end
end

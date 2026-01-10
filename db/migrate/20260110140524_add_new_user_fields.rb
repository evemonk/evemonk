# frozen_string_literal: true

class AddNewUserFields < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :email_address, :string, null: true
    add_column :users, :password_digest, :string, null: true
  end
end

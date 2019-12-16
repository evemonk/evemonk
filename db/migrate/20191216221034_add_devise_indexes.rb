# frozen_string_literal: true

class AddDeviseIndexes < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, name: "index_users_on_LOWER_email"

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true

    User.find_each do |user|
      user.update_columns(email: user.email.downcase)
    end
  end
end

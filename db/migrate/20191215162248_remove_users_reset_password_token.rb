# frozen_string_literal: true

class RemoveUsersResetPasswordToken < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, column: :reset_password_token, unique: true
    remove_column :users, :reset_password_token, :string
  end
end

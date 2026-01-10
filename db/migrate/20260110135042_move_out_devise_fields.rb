# frozen_string_literal: true

class MoveOutDeviseFields < ActiveRecord::Migration[8.1]
  def change
    remove_index :users, :confirmation_token, name: "index_users_on_confirmation_token", unique: true
    remove_index :users, :reset_password_token, name: "index_users_on_reset_password_token", unique: true
    remove_index :users, :email, name: "index_users_on_email", unique: true

    rename_column :users, :email, :devise_email
    rename_column :users, :unconfirmed_email, :devise_unconfirmed_email
    rename_column :users, :confirmation_token, :devise_confirmation_token
    rename_column :users, :confirmation_sent_at, :devise_confirmation_sent_at
    rename_column :users, :confirmed_at, :devise_confirmed_at
    rename_column :users, :reset_password_token, :devise_reset_password_token
    rename_column :users, :reset_password_sent_at, :devise_reset_password_sent_at
    rename_column :users, :remember_created_at, :devise_remember_created_at
    rename_column :users, :sign_in_count, :devise_sign_in_count
    rename_column :users, :last_sign_in_at, :devise_last_sign_in_at
    rename_column :users, :last_sign_in_ip, :devise_last_sign_in_ip
    rename_column :users, :current_sign_in_at, :devise_current_sign_in_at
    rename_column :users, :current_sign_in_ip, :devise_current_sign_in_ip
    rename_column :users, :encrypted_password, :devise_encrypted_password
  end
end

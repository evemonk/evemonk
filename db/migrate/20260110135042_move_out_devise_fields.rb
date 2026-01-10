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


    # t.string :email_address, null: false
    # t.string :password_digest, null: false


    # t.datetime "current_sign_in_at", precision: nil
    # t.inet "current_sign_in_ip"
    # t.string "encrypted_password", default: "", null: false
    # t.datetime "last_sign_in_at", precision: nil
    # t.inet "last_sign_in_ip"
    # t.integer "locale", default: 0
    # t.integer "notifications_count", default: 0
    # t.integer "sign_in_count", default: 0, null: false


  end
end

# frozen_string_literal: true

class DropSorcery < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :remember_me_token
    remove_index :users, [:last_logout_at, :last_activity_at]
    remove_index :users, :activation_token
    remove_column :users, :remember_me_token, :string
    remove_column :users, :remember_me_token_expires_at, :datetime
    remove_column :users, :activation_state, :string
    remove_column :users, :activation_token, :string
    remove_column :users, :activation_token_expires_at, :datetime
    remove_column :users, :last_login_at, :datetime
    remove_column :users, :last_logout_at, :datetime
    remove_column :users, :last_activity_at, :datetime
    remove_column :users, :last_login_from_ip_address, :string
  end
end

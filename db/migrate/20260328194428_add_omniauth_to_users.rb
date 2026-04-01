# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_index :users, [:provider, :uid], unique: true
    add_column :users, :guest, :boolean, default: false, null: false
  end
end

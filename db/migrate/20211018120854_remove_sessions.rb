# frozen_string_literal: true

class RemoveSessions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :sessions, :user
    remove_index :sessions, :token, unique: true
    drop_table :sessions do |t|
      t.string :token
      t.string :name
      t.string :device_token
      t.integer :device_type
      t.timestamps
    end
  end
end

# frozen_string_literal: true

class DropNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_index :notifications, :read_at

    drop_table :notifications
  end
end

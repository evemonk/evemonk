# frozen_string_literal: true

class RemoveRpush < ActiveRecord::Migration[6.1]
  def change
    drop_table :rpush_apps
    remove_index :rpush_feedback, :device_token
    drop_table :rpush_feedback
    remove_index :rpush_notifications, [:delivered, :failed, :processing, :deliver_after, :created_at], name: :index_rpush_notifications_multi
    drop_table :rpush_notifications
  end
end

# frozen_string_literal: true

class RemoveRpush < ActiveRecord::Migration[6.1]
  def change
    if index_exists?(:rpush_feedback, :device_token)
      remove_index :rpush_feedback, :device_token
    end

    if index_exists?(:rpush_notifications, [:delivered, :failed, :processing, :deliver_after, :created_at], name: :index_rpush_notifications_multi)
      remove_index :rpush_notifications, [:delivered, :failed, :processing, :deliver_after, :created_at], name: :index_rpush_notifications_multi
    end

    if table_exists?(:rpush_apps)
      drop_table :rpush_apps
    end

    if table_exists?(:rpush_feedback)
      drop_table :rpush_feedback
    end

    if table_exists?(:rpush_notifications)
      drop_table :rpush_notifications
    end
  end
end

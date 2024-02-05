# frozen_string_literal: true

class DropNotificationsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :notifications, id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string :recipient_type, null: false
      t.bigint :recipient_id, null: false
      t.string :type, null: false
      t.jsonb :params
      t.datetime :read_at, precision: nil
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index [:read_at], name: "index_notifications_on_read_at"
      t.index [:recipient_type, :recipient_id], name: "index_notifications_on_recipient"
    end
  end
end

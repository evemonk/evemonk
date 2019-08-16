# frozen_string_literal: true

class CreateEveServerStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_server_statuses do |t|
      t.bigint :players
      t.string :server_version
      t.datetime :start_time
      t.boolean :vip

      t.timestamps
    end
  end
end

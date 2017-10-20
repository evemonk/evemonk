# frozen_string_literal: true
class AddDeviceToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :device, :integer
  end
end

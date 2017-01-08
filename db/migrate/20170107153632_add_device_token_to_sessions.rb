class AddDeviceTokenToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :device_token, :string
  end
end

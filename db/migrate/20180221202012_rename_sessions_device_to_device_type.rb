class RenameSessionsDeviceToDeviceType < ActiveRecord::Migration[5.2]
  def change
    rename_column :sessions, :device, :device_type
  end
end

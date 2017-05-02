class AddStatusToApiKeys < ActiveRecord::Migration[5.1]
  def change
    add_column :api_keys, :status, :integer, default: ApiKey.statuses[:fresh]
  end
end

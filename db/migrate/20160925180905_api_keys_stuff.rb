class ApiKeysStuff < ActiveRecord::Migration[5.0]
  def change
    add_column :api_keys, :expires, :datetime
    add_column :api_keys, :api_key_type, :string
    add_column :api_keys, :access_mask, :integer
    add_column :api_keys, :current_time, :datetime
    add_column :api_keys, :cached_until, :datetime
  end
end

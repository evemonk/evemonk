class ChangeApiKeysAccessMaskLimit < ActiveRecord::Migration[5.0]
  def change
    change_column :api_keys, :access_mask, :integer, limit: 8
  end
end

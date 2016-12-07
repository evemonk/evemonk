class RemoveTokenFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :token, :string
  end
end

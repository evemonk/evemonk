class AddUsersEmailIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :users, 'LOWER(email)', unique: true
  end
end

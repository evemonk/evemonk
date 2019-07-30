# frozen_string_literal: true

class AddUsersEmailIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :users, "LOWER(email)", unique: true, name: "index_users_on_LOWER_email"
  end
end

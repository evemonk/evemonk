# frozen_string_literal: true

class RemoveUsersOldFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :password_digest, :string
  end
end

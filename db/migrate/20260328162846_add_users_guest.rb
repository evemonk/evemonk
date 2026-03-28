# frozen_string_literal: true

class AddUsersGuest < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :guest, :boolean, null: false, default: false
  end
end

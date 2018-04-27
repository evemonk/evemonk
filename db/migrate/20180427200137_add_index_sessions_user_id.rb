# frozen_string_literal: true

class AddIndexSessionsUserId < ActiveRecord::Migration[5.2]
  def change
    add_index :sessions, :user_id
  end
end

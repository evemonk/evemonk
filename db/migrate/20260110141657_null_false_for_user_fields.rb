# frozen_string_literal: true

class NullFalseForUserFields < ActiveRecord::Migration[8.1]
  def change
    change_column_null :users, :email_address, false
    change_column_null :users, :password_digest, false
  end
end

# frozen_string_literal: true

class AddAuthyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_sign_in_with_authy, :datetime
    add_column :users, :authy_enabled, :boolean, default: false
  end
end

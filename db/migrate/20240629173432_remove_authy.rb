# frozen_string_literal: true

class RemoveAuthy < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :authy_id, :string
    remove_column :users, :last_sign_in_with_authy, :datetime
    remove_column :users, :authy_enabled, :boolean, default: false
  end
end

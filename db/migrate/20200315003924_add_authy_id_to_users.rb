# frozen_string_literal: true

class AddAuthyIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authy_id, :string
  end
end

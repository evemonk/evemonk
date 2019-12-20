# frozen_string_literal: true

class DropUsersKind < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :kind, :integer, default: 0
  end
end

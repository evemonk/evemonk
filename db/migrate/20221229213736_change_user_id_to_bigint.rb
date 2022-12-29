# frozen_string_literal: true

class ChangeUserIdToBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :id, :bigint
  end
end

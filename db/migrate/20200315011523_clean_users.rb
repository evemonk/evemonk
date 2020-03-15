# frozen_string_literal: true

class CleanUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :phone_number, :string
    remove_column :users, :country_code, :string
  end
end

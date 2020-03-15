# frozen_string_literal: true

class AddPhoneNumberToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :phone_number, :string
  end
end

# frozen_string_literal: true

class AddCountryCodeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :country_code, :string
  end
end

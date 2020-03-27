# frozen_string_literal: true

class AddLocaleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :locale, :integer, default: 0
  end
end

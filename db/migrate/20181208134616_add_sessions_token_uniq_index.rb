# frozen_string_literal: true

class AddSessionsTokenUniqIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :sessions, :token, unique: true
  end
end

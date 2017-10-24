# frozen_string_literal: true

class AddIndexApiKeysStatus < ActiveRecord::Migration[5.1]
  def change
    add_index :api_keys, :status
  end
end

# frozen_string_literal: true

class DropApiKeys < ActiveRecord::Migration[5.1]
  def change
    drop_table :api_keys
  end
end

# frozen_string_literal: true

class AddStatusToApiKeys < ActiveRecord::Migration[5.1]
  def change
    add_column :api_keys, :status, :integer, default: 0
  end
end

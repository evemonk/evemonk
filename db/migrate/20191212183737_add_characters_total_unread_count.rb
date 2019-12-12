# frozen_string_literal: true

class AddCharactersTotalUnreadCount < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :total_unread_count, :integer, default: 0
  end
end

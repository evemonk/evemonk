# frozen_string_literal: true

class DropInvItems < ActiveRecord::Migration[5.2]
  def change
    drop_table :inv_items
  end
end

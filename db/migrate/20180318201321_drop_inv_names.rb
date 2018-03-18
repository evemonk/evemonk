# frozen_string_literal: true

class DropInvNames < ActiveRecord::Migration[5.2]
  def change
    drop_table :inv_names
  end
end

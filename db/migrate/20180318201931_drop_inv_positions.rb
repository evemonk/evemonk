# frozen_string_literal: true

class DropInvPositions < ActiveRecord::Migration[5.2]
  def change
    drop_table :inv_positions
  end
end

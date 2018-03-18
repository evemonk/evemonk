# frozen_string_literal: true

class DropInvFlags < ActiveRecord::Migration[5.2]
  def change
    drop_table :inv_flags
  end
end

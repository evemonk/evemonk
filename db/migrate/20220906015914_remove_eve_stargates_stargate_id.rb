# frozen_string_literal: true

class RemoveEveStargatesStargateId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_stargates, :stargate_id, unique: true
    remove_column :eve_stargates, :stargate_id, :bigint
  end
end

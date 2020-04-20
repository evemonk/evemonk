# frozen_string_literal: true

class AddIndexesEveStargates < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_stargates, :destination_stargate_id
    add_index :eve_stargates, :destination_system_id
  end
end

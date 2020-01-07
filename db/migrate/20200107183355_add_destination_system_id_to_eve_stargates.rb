# frozen_string_literal: true

class AddDestinationSystemIdToEveStargates < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_stargates, :destination_system_id, :bigint
  end
end

# frozen_string_literal: true

class AddDestinationStargateIdToEveStargates < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_stargates, :destination_stargate_id, :bigint
  end
end

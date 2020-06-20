# frozen_string_literal: true

class CreateEveContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_contracts, id: :uuid do |t|
      t.float :buyout
      t.float :collateral
      t.bigint :contract_id
      t.datetime :date_expired
      t.datetime :date_issued
      t.integer :days_to_complete
      t.bigint :end_location_id
      t.boolean :for_corporation
      t.bigint :issuer_corporation_id
      t.bigint :issuer_id
      t.float :price
      t.float :reward
      t.bigint :start_location_id
      t.string :title
      t.string :kind
      t.float :volume

      t.timestamps
    end
  end
end

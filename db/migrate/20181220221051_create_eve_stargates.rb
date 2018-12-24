# frozen_string_literal: true

class CreateEveStargates < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_stargates do |t|
      t.string :name
      t.bigint :stargate_id
      t.bigint :system_id
      t.bigint :type_id
      t.timestamps
      t.index :stargate_id, unique: true
      t.index :system_id
    end
  end
end

# frozen_string_literal: true

class CreateManufacturingJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :manufacturing_jobs do |t|
      t.references :character, null: false, foreign_key: true
      t.string :name
      t.bigint :product_id
      t.integer :quantity

      t.timestamps
    end
  end
end

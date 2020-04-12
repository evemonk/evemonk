# frozen_string_literal: true

class CreateEveBlueprintInventionProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_blueprint_invention_products do |t|
      t.bigint :blueprint_id
      t.float :probability
      t.integer :quantity
      t.bigint :type_id

      t.timestamps
    end
  end
end

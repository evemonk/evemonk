# frozen_string_literal: true

class CreateEveBlueprintManufacturingMaterials < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_blueprint_manufacturing_materials do |t|
      t.bigint :blueprint_id
      t.integer :quantity
      t.bigint :type_id

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateEveBlueprintInventionMaterials < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_blueprint_invention_materials do |t|
      t.bigint :blueprint_id
      t.integer :quantity
      t.bigint :type_id

      t.timestamps
    end
  end
end

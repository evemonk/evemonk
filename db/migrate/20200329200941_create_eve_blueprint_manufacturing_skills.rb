# frozen_string_literal: true

class CreateEveBlueprintManufacturingSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_blueprint_manufacturing_skills do |t|
      t.bigint :blueprint_id
      t.integer :level
      t.bigint :type_id

      t.timestamps
    end
  end
end

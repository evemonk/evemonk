# frozen_string_literal: true

class AddIndexesEveBlueprintManufacturingSkills < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_blueprint_manufacturing_skills, :blueprint_id
    add_index :eve_blueprint_manufacturing_skills, :type_id
  end
end

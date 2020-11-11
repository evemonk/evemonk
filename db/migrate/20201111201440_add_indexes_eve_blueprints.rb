# frozen_string_literal: true

class AddIndexesEveBlueprints < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_blueprint_invention_materials, :blueprint_id
    add_index :eve_blueprint_invention_products, :blueprint_id
    add_index :eve_blueprint_invention_skills, :blueprint_id
    add_index :eve_blueprint_manufacturing_materials, :blueprint_id
    add_index :eve_blueprint_manufacturing_products, :blueprint_id

    add_index :eve_blueprint_invention_materials, :type_id
    add_index :eve_blueprint_invention_products, :type_id
    add_index :eve_blueprint_invention_skills, :type_id
    add_index :eve_blueprint_manufacturing_materials, :type_id
    add_index :eve_blueprint_manufacturing_products, :type_id
  end
end

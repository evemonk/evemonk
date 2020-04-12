# frozen_string_literal: true

class AddTimesToEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :manufacturing_time, :bigint
    add_column :eve_types, :research_material_time, :bigint
    add_column :eve_types, :research_time_time, :bigint
  end
end

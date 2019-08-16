# frozen_string_literal: true

class AddCurrentStructureIdToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :current_structure_id, :bigint
  end
end

# frozen_string_literal: true

class RemoveEveTypesTypeId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_types, :type_id, unique: true
    remove_column :eve_types, :type_id, :bigint
  end
end

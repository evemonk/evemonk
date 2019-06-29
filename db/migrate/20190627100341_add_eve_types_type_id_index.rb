# frozen_string_literal: true

class AddEveTypesTypeIdIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_types, :type_id, unique: true
  end
end

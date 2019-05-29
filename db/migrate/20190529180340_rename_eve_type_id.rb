# frozen_string_literal: true

class RenameEveTypeId < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_type_dogma_attributes, :eve_type_id, :type_id
  end
end

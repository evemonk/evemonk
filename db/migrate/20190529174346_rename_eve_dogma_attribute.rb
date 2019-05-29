# frozen_string_literal: true

class RenameEveDogmaAttribute < ActiveRecord::Migration[6.0]
  def change
    rename_table :eve_dogma_attributes, :eve_type_dogma_attributes
  end
end

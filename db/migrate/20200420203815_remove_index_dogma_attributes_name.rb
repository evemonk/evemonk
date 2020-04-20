# frozen_string_literal: true

class RemoveIndexDogmaAttributesName < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_dogma_attributes, :name
  end
end

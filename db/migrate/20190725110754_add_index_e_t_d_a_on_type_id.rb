# frozen_string_literal: true

class AddIndexETDAOnTypeId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_type_dogma_attributes, :type_id
  end
end

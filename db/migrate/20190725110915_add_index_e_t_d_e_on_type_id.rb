# frozen_string_literal: true

class AddIndexETDEOnTypeId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_type_dogma_effects, :type_id
  end
end

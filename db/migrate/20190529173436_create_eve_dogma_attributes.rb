# frozen_string_literal: true

class CreateEveDogmaAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_dogma_attributes do |t|
      t.bigint :eve_type_id
      t.bigint :attribute_id
      t.float :value

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateEveTypeDogmaEffects < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_type_dogma_effects do |t|
      t.bigint :type_id
      t.bigint :effect_id
      t.boolean :is_default

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateEveTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_types do |t|
      t.float :capacity
      t.text :description
      t.bigint :graphic_id
      t.bigint :group_id
      t.bigint :icon_id
      t.bigint :market_group_id
      t.float :mass
      t.string :name
      t.float :packaged_volume
      t.integer :portion_size
      t.boolean :published
      t.float :radius
      t.bigint :type_id
      t.float :volume

      t.timestamps
    end
  end
end

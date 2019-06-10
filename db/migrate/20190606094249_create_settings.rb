# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[6.0]
  def up
    create_table :settings do |t|
      t.string :var, null: false
      t.text :value, null: true

      t.timestamps
    end

    add_index :settings, :var, unique: true
  end
end

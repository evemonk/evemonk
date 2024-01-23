# frozen_string_literal: true

class CreateFlipperTables < ActiveRecord::Migration[7.0]
  def change
    create_table :flipper_features do |t|
      t.string :key, null: false
      t.timestamps null: false
    end
    add_index :flipper_features, :key, unique: true

    create_table :flipper_gates do |t|
      t.string :feature_key, null: false
      t.string :key, null: false
      t.string :value
      t.timestamps null: false
    end
    add_index :flipper_gates, [:feature_key, :key, :value], unique: true
  end
end

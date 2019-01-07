# frozen_string_literal: true

class IntegerToBigint < ActiveRecord::Migration[6.0]
  def change
    remove_index :characters, :corporation_id
    remove_column :characters, :corporation_id, :integer
    add_column :characters, :corporation_id, :bigint
    add_index :characters, :corporation_id

    remove_index :characters, :race_id
    remove_column :characters, :race_id, :integer
    add_column :characters, :race_id, :bigint
    add_index :characters, :race_id

    remove_index :characters, :bloodline_id
    remove_column :characters, :bloodline_id, :integer
    add_column :characters, :bloodline_id, :bigint
    add_index :characters, :bloodline_id

    remove_index :characters, :ancestry_id
    remove_column :characters, :ancestry_id, :integer
    add_column :characters, :ancestry_id, :bigint
    add_index :characters, :ancestry_id

    remove_index :characters, :faction_id
    remove_column :characters, :faction_id, :integer
    add_column :characters, :faction_id, :bigint
    add_index :characters, :faction_id
  end
end

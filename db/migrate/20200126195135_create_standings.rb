# frozen_string_literal: true

class CreateStandings < ActiveRecord::Migration[6.0]
  def change
    create_table :standings do |t|
      t.bigint :character_id
      t.bigint :from_id
      t.string :from_type
      t.float :standing

      t.timestamps
    end

    add_index :standings, :character_id
    add_foreign_key :standings, :characters
  end
end

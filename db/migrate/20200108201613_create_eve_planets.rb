# frozen_string_literal: true

class CreateEvePlanets < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_planets do |t|
      t.string :name
      t.bigint :planet_id
      t.bigint :system_id
      t.bigint :type_id

      t.timestamps
    end
  end
end

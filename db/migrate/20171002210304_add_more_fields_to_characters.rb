# frozen_string_literal: true

class AddMoreFieldsToCharacters < ActiveRecord::Migration[5.1]
  def change
    change_table :characters, bulk: true do |t|
      t.integer :corporation_id
      t.datetime :birthday
      t.string :gender
      t.integer :race_id
      t.integer :bloodline_id
      t.text :description
      t.integer :alliance_id
      t.integer :ancestry_id
      t.decimal :security_status, precision: 18, scale: 16
    end
  end
end

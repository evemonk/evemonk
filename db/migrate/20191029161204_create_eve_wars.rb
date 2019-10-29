# frozen_string_literal: true

class CreateEveWars < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_wars do |t|
      t.bigint :war_id
      t.datetime :declared
      t.datetime :finished
      t.boolean :mutual
      t.boolean :open_for_allies
      t.datetime :retracted
      t.datetime :started

      t.timestamps
    end
  end
end

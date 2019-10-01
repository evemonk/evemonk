# frozen_string_literal: true

class CreateSkillqueues < ActiveRecord::Migration[6.0]
  def change
    create_table :skillqueues do |t|
      t.references :character, null: false, foreign_key: true
      t.datetime :finish_date
      t.integer :finished_level
      t.integer :level_end_sp
      t.integer :level_start_sp
      t.integer :queue_position
      t.bigint :skill_id
      t.datetime :start_date
      t.integer :training_start_sp

      t.timestamps
    end
  end
end

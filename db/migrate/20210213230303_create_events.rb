# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :character, null: false, foreign_key: true
      t.bigint :event_id
      t.string :text
      t.string :title
      t.bigint :owner_id
      t.string :owner_name
      t.string :owner_type
      t.integer :duration
      t.datetime :event_date
      t.string :event_response
      t.integer :importance

      t.timestamps
    end
  end
end

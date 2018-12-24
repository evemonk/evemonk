# frozen_string_literal: true

class CreateEveSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_systems do |t|
      t.bigint :constellation_id
      t.string :name
      t.string :security_class
      t.float :security_status
      t.bigint :star_id
      t.bigint :system_id
      t.timestamps
      t.index :constellation_id
      t.index :star_id
      t.index :system_id, unique: true
    end
  end
end

# frozen_string_literal: true

class CreateEveAllianceCorporations < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_alliance_corporations do |t|
      t.bigint :alliance_id
      t.bigint :corporation_id
      t.timestamps
      t.index :alliance_id
      t.index :corporation_id
    end
  end
end

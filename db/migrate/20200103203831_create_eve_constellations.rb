# frozen_string_literal: true

class CreateEveConstellations < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_constellations do |t|
      t.bigint :constellation_id
      t.string :name_en
      t.string :name_de
      t.string :name_fr
      t.string :name_ja
      t.string :name_ru
      t.string :name_zh
      t.string :name_ko
      t.bigint :region_id

      t.timestamps
    end
  end
end

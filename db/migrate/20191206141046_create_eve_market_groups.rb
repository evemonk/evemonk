# frozen_string_literal: true

class CreateEveMarketGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_market_groups do |t|
      t.text :description_en
      t.text :description_de
      t.text :description_fr
      t.text :description_ja
      t.text :description_ru
      t.text :description_zh
      t.text :description_ko
      t.bigint :market_group_id
      t.string :name_en
      t.string :name_de
      t.string :name_fr
      t.string :name_ja
      t.string :name_ru
      t.string :name_zh
      t.string :name_ko
      t.bigint :parent_group_id

      t.timestamps
    end
  end
end

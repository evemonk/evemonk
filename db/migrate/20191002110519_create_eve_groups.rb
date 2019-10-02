# frozen_string_literal: true

class CreateEveGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_groups do |t|
      t.bigint :category_id
      t.bigint :group_id
      t.string :name_en
      t.string :name_de
      t.string :name_fr
      t.string :name_ja
      t.string :name_ru
      t.string :name_zh
      t.boolean :published

      t.timestamps
    end
  end
end

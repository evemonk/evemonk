# frozen_string_literal: true

class CreateEveNpcCorporationDivisions < ActiveRecord::Migration[7.0]
  def change
    create_table :eve_npc_corporation_divisions do |t|
      t.text :description
      t.text :description_full_en
      t.text :description_full_de
      t.text :description_full_fr
      t.text :description_full_ja
      t.text :description_full_ko
      t.text :description_full_ru
      t.text :description_full_zh
      t.string :internal_name
      t.string :leader_type_name_en
      t.string :leader_type_name_de
      t.string :leader_type_name_fr
      t.string :leader_type_name_ja
      t.string :leader_type_name_ko
      t.string :leader_type_name_ru
      t.string :leader_type_name_zh
      t.string :name_en
      t.string :name_de
      t.string :name_fr
      t.string :name_ja
      t.string :name_ko
      t.string :name_ru
      t.string :name_zh

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class AddLanguagesRaces < ActiveRecord::Migration[7.0]
  def change
    change_table :eve_races, bulk: true do |t|
      t.string :name_zh
      t.string :name_es
      t.text :description_zh
      t.text :description_es
    end
  end
end

# frozen_string_literal: true

class AddIndexesEvePlanets < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_planets, :system_id
    add_index :eve_planets, :type_id
  end
end

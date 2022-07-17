# frozen_string_literal: true

class RemoveEveStarsStarId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_stars, :star_id, unique: true
    remove_column :eve_stars, :star_id, :bigint
  end
end

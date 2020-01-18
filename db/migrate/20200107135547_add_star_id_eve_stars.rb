# frozen_string_literal: true

class AddStarIdEveStars < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_stars, :star_id, :bigint
    add_index :eve_stars, :star_id
  end
end

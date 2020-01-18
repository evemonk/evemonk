# frozen_string_literal: true

class FixIndexEveStars < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_stars, :star_id
    add_index :eve_stars, :star_id, unique: true
  end
end

# frozen_string_literal: true

class AddIndexEveStarTypeId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_stars, :type_id
  end
end

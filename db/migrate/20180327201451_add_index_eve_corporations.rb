# frozen_string_literal: true

class AddIndexEveCorporations < ActiveRecord::Migration[5.2]
  def change
    add_index :eve_corporations, :corporation_id, unique: true
  end
end

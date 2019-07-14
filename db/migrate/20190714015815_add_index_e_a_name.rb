# frozen_string_literal: true

class AddIndexEAName < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_alliances, :name
  end
end

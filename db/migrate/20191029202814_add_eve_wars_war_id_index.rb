# frozen_string_literal: true

class AddEveWarsWarIdIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_wars, :war_id, unique: true
  end
end

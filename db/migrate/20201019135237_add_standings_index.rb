# frozen_string_literal: true

class AddStandingsIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :standings, :from_id
  end
end

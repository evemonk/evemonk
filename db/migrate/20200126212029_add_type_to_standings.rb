# frozen_string_literal: true

class AddTypeToStandings < ActiveRecord::Migration[6.0]
  def change
    add_column :standings, :standingable_id, :bigint
    add_column :standings, :standingable_type, :string
  end
end

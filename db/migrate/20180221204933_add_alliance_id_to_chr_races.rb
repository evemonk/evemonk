# frozen_string_literal: true

class AddAllianceIdToChrRaces < ActiveRecord::Migration[5.2]
  def change
    add_column :chr_races, :alliance_id, :integer
  end
end

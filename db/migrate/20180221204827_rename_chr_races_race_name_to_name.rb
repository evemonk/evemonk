# frozen_string_literal: true

class RenameChrRacesRaceNameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :chr_races, :race_name, :name
  end
end

class RenameChrRacesToEveRaces < ActiveRecord::Migration[5.2]
  def change
    rename_table :chr_races, :eve_races
  end
end

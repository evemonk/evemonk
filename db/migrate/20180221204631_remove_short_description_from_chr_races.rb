class RemoveShortDescriptionFromChrRaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :chr_races, :short_description, :string
  end
end

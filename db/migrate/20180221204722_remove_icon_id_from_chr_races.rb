# frozen_string_literal: true

class RemoveIconIdFromChrRaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :chr_races, :icon_id, :integer
  end
end

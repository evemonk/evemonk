# frozen_string_literal: true

class AddNameKoEveRaces < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_races, :name_ko, :string
  end
end

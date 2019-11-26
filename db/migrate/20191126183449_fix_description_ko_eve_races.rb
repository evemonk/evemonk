# frozen_string_literal: true

class FixDescriptionKoEveRaces < ActiveRecord::Migration[6.0]
  def change
    remove_column :eve_races, :description_ko, :string
    add_column :eve_races, :description_ko, :text
  end
end

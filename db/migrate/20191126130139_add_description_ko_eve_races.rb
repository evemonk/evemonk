# frozen_string_literal: true

class AddDescriptionKoEveRaces < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_races, :description_ko, :string
  end
end

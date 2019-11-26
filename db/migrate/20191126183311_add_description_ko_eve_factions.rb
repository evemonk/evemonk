# frozen_string_literal: true

class AddDescriptionKoEveFactions < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_factions, :description_ko, :text
  end
end

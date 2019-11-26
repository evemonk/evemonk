# frozen_string_literal: true

class AddNameKoToEveFactions < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_factions, :name_ko, :string
  end
end

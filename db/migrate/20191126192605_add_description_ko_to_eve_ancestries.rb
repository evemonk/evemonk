# frozen_string_literal: true

class AddDescriptionKoToEveAncestries < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_ancestries, :description_ko, :text
  end
end

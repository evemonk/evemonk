# frozen_string_literal: true

class AddDescriptionKoToEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :description_ko, :text
  end
end

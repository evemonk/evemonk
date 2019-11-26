# frozen_string_literal: true

class AddDescriptionKoToEveBloodlines < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_bloodlines, :description_ko, :text
  end
end

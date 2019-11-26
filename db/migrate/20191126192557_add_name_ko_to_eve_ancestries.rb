# frozen_string_literal: true

class AddNameKoToEveAncestries < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_ancestries, :name_ko, :string
  end
end

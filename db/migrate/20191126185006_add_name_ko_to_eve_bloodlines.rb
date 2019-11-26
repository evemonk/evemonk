# frozen_string_literal: true

class AddNameKoToEveBloodlines < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_bloodlines, :name_ko, :string
  end
end

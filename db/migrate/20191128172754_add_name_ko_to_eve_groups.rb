# frozen_string_literal: true

class AddNameKoToEveGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_groups, :name_ko, :string
  end
end

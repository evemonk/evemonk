# frozen_string_literal: true

class AddIsBlueprintToEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :is_blueprint, :boolean
  end
end

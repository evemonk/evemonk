# frozen_string_literal: true

class AddMaxProductionLimitEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :max_production_limit, :integer
  end
end

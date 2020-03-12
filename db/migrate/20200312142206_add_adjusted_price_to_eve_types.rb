# frozen_string_literal: true

class AddAdjustedPriceToEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :adjusted_price, :float
  end
end

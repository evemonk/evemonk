# frozen_string_literal: true

class AddBasePriceToEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :base_price, :float
  end
end

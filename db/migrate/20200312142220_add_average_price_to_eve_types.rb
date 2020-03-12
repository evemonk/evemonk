# frozen_string_literal: true

class AddAveragePriceToEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :average_price, :float
  end
end

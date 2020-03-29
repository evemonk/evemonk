# frozen_string_literal: true

class AddInventionTimeToEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :invention_time, :bigint
  end
end

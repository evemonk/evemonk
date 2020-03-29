# frozen_string_literal: true

class AddCopyingTimeToEveTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_types, :copying_time, :bigint
  end
end

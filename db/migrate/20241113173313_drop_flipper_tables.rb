# frozen_string_literal: true

class DropFlipperTables < ActiveRecord::Migration[7.2]
  def change
    drop_table :flipper_features
    drop_table :flipper_gates
  end
end

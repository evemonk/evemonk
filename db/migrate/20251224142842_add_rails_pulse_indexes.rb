# frozen_string_literal: true

class AddRailsPulseIndexes < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    add_index :rails_pulse_summaries, :summarizable_id, algorithm: :concurrently
    add_index :rails_pulse_routes, :path, algorithm: :concurrently
    add_index :rails_pulse_summaries, :period_start, algorithm: :concurrently
  end
end

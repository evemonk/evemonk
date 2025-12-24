# frozen_string_literal: true

class FixRailsPulseIndexes < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    remove_index :rails_pulse_operations, :created_at, algorithm: :concurrently, name: :idx_operations_created_at

    remove_index :rails_pulse_operations, :occurred_at, algorithm: :concurrently, name: :index_rails_pulse_operations_on_occurred_at

    remove_index :rails_pulse_operations, :query_id, algorithm: :concurrently, name: :index_rails_pulse_operations_on_query_id

    remove_index :rails_pulse_requests, :created_at, algorithm: :concurrently, name: :idx_requests_created_at

    remove_index :rails_pulse_requests, :route_id, algorithm: :concurrently, name: :index_rails_pulse_requests_on_route_id

    remove_index :rails_pulse_summaries, [:summarizable_type, :summarizable_id], algorithm: :concurrently, name: :index_rails_pulse_summaries_on_summarizable
  end
end

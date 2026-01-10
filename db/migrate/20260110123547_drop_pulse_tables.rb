# frozen_string_literal: true

class DropPulseTables < ActiveRecord::Migration[8.1]
  def change
    remove_index :rails_pulse_operations, :created_at, name: "idx_operations_created_at"
    remove_index :rails_pulse_operations, [:created_at, :query_id], name: "idx_operations_for_aggregation"
    remove_index :rails_pulse_requests, :created_at, name: "idx_requests_created_at"
    remove_index :rails_pulse_requests, [:created_at, :route_id], name: "idx_requests_for_aggregation"
    remove_index :rails_pulse_summaries, :created_at, name: "index_rails_pulse_summaries_on_created_at"
    remove_index :rails_pulse_summaries, [:period_type, :period_start], name: "index_rails_pulse_summaries_on_period"
    remove_index :rails_pulse_summaries, [:summarizable_type, :summarizable_id, :period_type, :period_start], unique: true, name: "idx_pulse_summaries_unique"

    drop_table :rails_pulse_summaries

    remove_index :rails_pulse_operations, [:occurred_at, :duration, :operation_type], name: "index_rails_pulse_operations_on_time_duration_type"
    remove_index :rails_pulse_operations, [:query_id, :duration, :occurred_at], name: "index_rails_pulse_operations_query_performance"
    remove_index :rails_pulse_operations, [:query_id, :occurred_at], name: "index_rails_pulse_operations_on_query_and_time"
    remove_index :rails_pulse_operations, :occurred_at, name: "index_rails_pulse_operations_on_occurred_at"
    remove_index :rails_pulse_operations, :operation_type, name: "index_rails_pulse_operations_on_operation_type"

    drop_table :rails_pulse_operations

    remove_index :rails_pulse_requests, [:route_id, :occurred_at], name: "index_rails_pulse_requests_on_route_id_and_occurred_at"
    remove_index :rails_pulse_requests, :request_uuid, unique: true, name: "index_rails_pulse_requests_on_request_uuid"
    remove_index :rails_pulse_requests, :occurred_at, name: "index_rails_pulse_requests_on_occurred_at"

    drop_table :rails_pulse_requests

    remove_index :rails_pulse_queries, :normalized_sql, unique: true, name: "index_rails_pulse_queries_on_normalized_sql", length: 191

    drop_table :rails_pulse_queries

    remove_index :rails_pulse_routes, [:method, :path], unique: true, name: "index_rails_pulse_routes_on_method_and_path"

    drop_table :rails_pulse_routes
  end
end

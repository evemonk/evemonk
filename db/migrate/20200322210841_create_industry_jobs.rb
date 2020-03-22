# frozen_string_literal: true

class CreateIndustryJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :industry_jobs do |t|
      t.references :character, null: false, foreign_key: true
      t.bigint :activity_id
      t.bigint :blueprint_id
      t.bigint :blueprint_location_id
      t.bigint :blueprint_type_id
      t.bigint :completed_character_id
      t.datetime :completed_date
      t.float :cost
      t.integer :duration
      t.datetime :end_date
      t.bigint :facility_id
      t.bigint :installer_id
      t.bigint :job_id
      t.integer :licensed_runs
      t.bigint :output_location_id
      t.datetime :pause_date
      t.float :probability
      t.integer :product_type_id
      t.integer :runs
      t.datetime :start_date
      t.bigint :station_id
      t.string :status
      t.integer :successful_runs

      t.timestamps
    end
  end
end

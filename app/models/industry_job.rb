# frozen_string_literal: true

class IndustryJob < ApplicationRecord
  belongs_to :character

  belongs_to :product_type, class_name: "Eve::Type", optional: true

  belongs_to :blueprint_type, class_name: "Eve::Type", optional: true
end

# create_table "industry_jobs", force: :cascade do |t|
#   t.bigint "character_id", null: false
#   t.bigint "activity_id"
#   t.bigint "blueprint_id"
#   t.bigint "blueprint_location_id"
#   t.bigint "blueprint_type_id"
#   t.bigint "completed_character_id"
#   t.datetime "completed_date"
#   t.float "cost"
#   t.integer "duration"
#   t.datetime "end_date"
#   t.bigint "facility_id"
#   t.bigint "installer_id"
#   t.bigint "job_id"
#   t.integer "licensed_runs"
#   t.bigint "output_location_id"
#   t.datetime "pause_date"
#   t.float "probability"
#   t.integer "product_type_id"
#   t.integer "runs"
#   t.datetime "start_date"
#   t.bigint "station_id"
#   t.string "status"
#   t.integer "successful_runs"
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.index ["character_id"], name: "index_industry_jobs_on_character_id"
# end

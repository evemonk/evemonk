# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_03_181712) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_buffercache"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "sslinfo"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "character_assets", force: :cascade do |t|
    t.bigint "character_id"
    t.boolean "is_blueprint_copy"
    t.boolean "is_singleton"
    t.bigint "item_id"
    t.string "location_flag"
    t.bigint "location_id"
    t.string "location_type"
    t.bigint "quantity"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_assets_on_character_id"
  end

  create_table "character_blueprints", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "item_id"
    t.string "location_flag"
    t.bigint "location_id"
    t.integer "material_efficiency"
    t.integer "quantity"
    t.integer "runs"
    t.integer "time_efficiency"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_blueprints_on_character_id"
  end

  create_table "character_corporation_histories", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "corporation_id"
    t.boolean "is_deleted"
    t.bigint "record_id"
    t.datetime "start_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id", "corporation_id"], name: "index_char_corp_histories_on_char_id_and_corp_id"
    t.index ["corporation_id"], name: "index_character_corporation_histories_on_corporation_id"
    t.index ["record_id"], name: "index_character_corporation_histories_on_record_id"
  end

  create_table "character_implants", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_implants_on_character_id"
    t.index ["type_id"], name: "index_character_implants_on_type_id"
  end

  create_table "character_killmails", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "killmail_hash"
    t.bigint "killmail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_killmails_on_character_id"
    t.index ["killmail_hash"], name: "index_character_killmails_on_killmail_hash", unique: true
    t.index ["killmail_id"], name: "index_character_killmails_on_killmail_id", unique: true
  end

  create_table "character_mail_labels", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "color"
    t.integer "label_id"
    t.string "name"
    t.integer "unread_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_mail_labels_on_character_id"
  end

  create_table "character_orders", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.integer "duration"
    t.float "escrow"
    t.boolean "is_buy_order"
    t.boolean "is_corporation"
    t.datetime "issued", precision: nil
    t.bigint "location_id"
    t.integer "min_volume"
    t.bigint "order_id"
    t.float "price"
    t.string "range"
    t.bigint "region_id"
    t.bigint "type_id"
    t.integer "volume_remain"
    t.integer "volume_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_orders_on_character_id"
  end

  create_table "character_scopes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "token_expires_at", precision: nil
    t.boolean "token_expires"
    t.string "token_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "scope", null: false
    t.boolean "esi_token_valid", default: true
    t.datetime "esi_token_invalid_at", precision: nil
    t.text "esi_last_error"
    t.index ["character_id"], name: "index_character_scopes_on_character_id"
  end

  create_table "character_skills", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.integer "active_skill_level"
    t.integer "skill_id"
    t.integer "skillpoints_in_skill"
    t.integer "trained_skill_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_skills_on_character_id"
  end

  create_table "characters", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "token_expires_at", precision: nil
    t.boolean "token_expires"
    t.string "token_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "birthday", precision: nil
    t.string "gender"
    t.text "description"
    t.decimal "security_status", precision: 18, scale: 16
    t.float "wallet"
    t.integer "charisma"
    t.integer "intelligence"
    t.integer "memory"
    t.integer "perception"
    t.integer "willpower"
    t.integer "bonus_remaps"
    t.datetime "last_remap_date", precision: nil
    t.datetime "accrued_remap_cooldown_date", precision: nil
    t.bigint "character_id"
    t.bigint "alliance_id"
    t.bigint "corporation_id"
    t.bigint "race_id"
    t.bigint "bloodline_id"
    t.bigint "faction_id"
    t.text "scopes"
    t.string "character_owner_hash"
    t.string "title"
    t.bigint "current_solar_system_id"
    t.bigint "current_station_id"
    t.bigint "current_structure_id"
    t.bigint "current_ship_item_id"
    t.string "current_ship_name"
    t.bigint "current_ship_type_id"
    t.bigint "total_sp"
    t.bigint "unallocated_sp"
    t.integer "total_unread_count", default: 0
    t.datetime "last_clone_jump_date", precision: nil
    t.datetime "last_station_change_date", precision: nil
    t.boolean "esi_token_valid", default: true
    t.datetime "esi_token_invalid_at", precision: nil
    t.text "esi_last_error"
    t.boolean "online"
    t.index ["alliance_id"], name: "index_characters_on_alliance_id"
    t.index ["bloodline_id"], name: "index_characters_on_bloodline_id"
    t.index ["character_id"], name: "index_characters_on_character_id", unique: true
    t.index ["character_owner_hash"], name: "index_characters_on_character_owner_hash", unique: true
    t.index ["corporation_id"], name: "index_characters_on_corporation_id"
    t.index ["current_ship_item_id"], name: "index_characters_on_current_ship_item_id"
    t.index ["current_ship_type_id"], name: "index_characters_on_current_ship_type_id"
    t.index ["current_solar_system_id"], name: "index_characters_on_current_solar_system_id"
    t.index ["current_station_id"], name: "index_characters_on_current_station_id"
    t.index ["current_structure_id"], name: "index_characters_on_current_structure_id"
    t.index ["faction_id"], name: "index_characters_on_faction_id"
    t.index ["race_id"], name: "index_characters_on_race_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "etags", force: :cascade do |t|
    t.text "url", null: false
    t.text "etag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "body"
    t.bigint "character_id"
    t.index ["url"], name: "index_etags_on_url"
  end

  create_table "eve_agents", force: :cascade do |t|
    t.bigint "agent_type_id"
    t.bigint "corporation_id"
    t.bigint "division_id"
    t.boolean "is_locator"
    t.integer "level"
    t.bigint "location_id"
    t.integer "quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["agent_type_id"], name: "index_eve_agents_on_agent_type_id"
    t.index ["corporation_id"], name: "index_eve_agents_on_corporation_id"
    t.index ["division_id"], name: "index_eve_agents_on_division_id"
    t.index ["location_id"], name: "index_eve_agents_on_location_id"
  end

  create_table "eve_alliances", force: :cascade do |t|
    t.bigint "creator_corporation_id"
    t.bigint "creator_id"
    t.datetime "date_founded", precision: nil
    t.bigint "executor_corporation_id"
    t.bigint "faction_id"
    t.string "name"
    t.string "ticker"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "corporations_count", default: 0
    t.bigint "characters_count", default: 0
    t.index ["characters_count"], name: "index_eve_alliances_on_characters_count"
    t.index ["creator_corporation_id"], name: "index_eve_alliances_on_creator_corporation_id"
    t.index ["creator_id"], name: "index_eve_alliances_on_creator_id"
    t.index ["executor_corporation_id"], name: "index_eve_alliances_on_executor_corporation_id"
    t.index ["faction_id"], name: "index_eve_alliances_on_faction_id"
    t.index ["name", "ticker"], name: "index_eve_alliances_on_name_and_ticker", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "eve_ancestries", force: :cascade do |t|
    t.bigint "ancestry_id"
    t.bigint "bloodline_id"
    t.text "description_en"
    t.integer "icon_id"
    t.string "name_en"
    t.text "short_description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.text "description_de"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ru"
    t.string "name_ko"
    t.text "description_ko"
    t.string "name_zh"
    t.string "name_es"
    t.text "description_zh"
    t.text "description_es"
    t.index ["ancestry_id"], name: "index_eve_ancestries_on_ancestry_id", unique: true
  end

  create_table "eve_asteroid_belts", force: :cascade do |t|
    t.bigint "asteroid_belt_id"
    t.string "name"
    t.bigint "system_id"
    t.bigint "planet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asteroid_belt_id"], name: "index_eve_asteroid_belts_on_asteroid_belt_id", unique: true
    t.index ["planet_id"], name: "index_eve_asteroid_belts_on_planet_id"
    t.index ["system_id"], name: "index_eve_asteroid_belts_on_system_id"
  end

  create_table "eve_bloodlines", force: :cascade do |t|
    t.bigint "bloodline_id"
    t.integer "charisma"
    t.bigint "corporation_id"
    t.text "description_en"
    t.integer "intelligence"
    t.integer "memory"
    t.string "name_en"
    t.integer "perception"
    t.bigint "race_id"
    t.bigint "ship_type_id"
    t.integer "willpower"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.text "description_de"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ru"
    t.string "name_ko"
    t.text "description_ko"
    t.string "name_zh"
    t.string "name_es"
    t.text "description_zh"
    t.text "description_es"
    t.index ["bloodline_id"], name: "index_eve_bloodlines_on_bloodline_id", unique: true
  end

  create_table "eve_blueprint_invention_materials", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_invention_materials_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_invention_materials_on_type_id"
  end

  create_table "eve_blueprint_invention_products", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.float "probability"
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_invention_products_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_invention_products_on_type_id"
  end

  create_table "eve_blueprint_invention_skills", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.integer "level"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_invention_skills_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_invention_skills_on_type_id"
  end

  create_table "eve_blueprint_manufacturing_materials", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_manufacturing_materials_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_manufacturing_materials_on_type_id"
  end

  create_table "eve_blueprint_manufacturing_products", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_manufacturing_products_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_manufacturing_products_on_type_id"
  end

  create_table "eve_blueprint_manufacturing_skills", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.integer "level"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_manufacturing_skills_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_manufacturing_skills_on_type_id"
  end

  create_table "eve_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name_en"
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_ko"
    t.index ["category_id"], name: "index_eve_categories_on_category_id", unique: true
  end

  create_table "eve_certificate_recommended_types", force: :cascade do |t|
    t.bigint "certificate_id"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["certificate_id"], name: "index_eve_certificate_recommended_types_on_certificate_id"
  end

  create_table "eve_certificate_skills", force: :cascade do |t|
    t.bigint "certificate_id"
    t.bigint "type_id"
    t.integer "level"
    t.integer "skill_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["certificate_id"], name: "index_eve_certificate_skills_on_certificate_id"
  end

  create_table "eve_certificates", force: :cascade do |t|
    t.text "description"
    t.bigint "group_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eve_character_attributes", force: :cascade do |t|
    t.integer "attribute_id"
    t.string "name_en"
    t.text "description"
    t.integer "icon_id"
    t.text "notes"
    t.text "short_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.string "name_ko"
  end

  create_table "eve_character_corporation_histories", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "corporation_id"
    t.boolean "is_deleted"
    t.bigint "record_id"
    t.datetime "start_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id", "corporation_id"], name: "index_eve_char_corp_histories_on_char_id_and_corp_id"
    t.index ["corporation_id"], name: "index_eve_character_corporation_histories_on_corporation_id"
    t.index ["record_id"], name: "index_eve_character_corporation_histories_on_record_id"
  end

  create_table "eve_characters", force: :cascade do |t|
    t.bigint "alliance_id"
    t.datetime "birthday", precision: nil
    t.bigint "bloodline_id"
    t.bigint "corporation_id"
    t.text "description"
    t.bigint "faction_id"
    t.string "gender"
    t.string "name"
    t.bigint "race_id"
    t.float "security_status"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "title"
    t.index ["alliance_id"], name: "index_eve_characters_on_alliance_id"
    t.index ["bloodline_id"], name: "index_eve_characters_on_bloodline_id"
    t.index ["corporation_id"], name: "index_eve_characters_on_corporation_id"
    t.index ["faction_id"], name: "index_eve_characters_on_faction_id"
    t.index ["name"], name: "index_eve_characters_on_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["race_id"], name: "index_eve_characters_on_race_id"
  end

  create_table "eve_constellations", force: :cascade do |t|
    t.bigint "constellation_id"
    t.string "name_en"
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.string "name_ko"
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["constellation_id"], name: "index_eve_constellations_on_constellation_id", unique: true
    t.index ["region_id"], name: "index_eve_constellations_on_region_id"
  end

  create_table "eve_contracts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "buyout"
    t.float "collateral"
    t.bigint "contract_id"
    t.datetime "date_expired", precision: nil
    t.datetime "date_issued", precision: nil
    t.integer "days_to_complete"
    t.bigint "end_location_id"
    t.boolean "for_corporation"
    t.bigint "issuer_corporation_id"
    t.bigint "issuer_id"
    t.float "price"
    t.float "reward"
    t.bigint "start_location_id"
    t.string "title"
    t.string "kind"
    t.float "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "region_id"
  end

  create_table "eve_corporation_alliance_histories", force: :cascade do |t|
    t.bigint "corporation_id"
    t.bigint "alliance_id"
    t.boolean "is_deleted"
    t.bigint "record_id"
    t.datetime "start_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alliance_id"], name: "index_eve_corporation_alliance_histories_on_alliance_id"
    t.index ["corporation_id"], name: "index_eve_corporation_alliance_histories_on_corporation_id"
    t.index ["record_id"], name: "index_eve_corporation_alliance_histories_on_record_id"
  end

  create_table "eve_corporations", force: :cascade do |t|
    t.bigint "corporation_id"
    t.bigint "alliance_id"
    t.bigint "ceo_id"
    t.bigint "creator_id"
    t.datetime "date_founded", precision: nil
    t.text "description"
    t.bigint "faction_id"
    t.bigint "home_station_id"
    t.integer "member_count"
    t.string "name"
    t.bigint "shares"
    t.float "tax_rate"
    t.string "ticker"
    t.text "corporation_url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "war_eligible"
    t.boolean "npc", default: false
    t.index ["alliance_id"], name: "index_eve_corporations_on_alliance_id"
    t.index ["ceo_id"], name: "index_eve_corporations_on_ceo_id"
    t.index ["corporation_id"], name: "index_eve_corporations_on_corporation_id", unique: true
    t.index ["creator_id"], name: "index_eve_corporations_on_creator_id"
    t.index ["faction_id"], name: "index_eve_corporations_on_faction_id"
    t.index ["home_station_id"], name: "index_eve_corporations_on_home_station_id"
    t.index ["member_count"], name: "index_eve_corporations_on_member_count"
    t.index ["name", "ticker"], name: "index_eve_corporations_on_name_and_ticker", opclass: :gin_trgm_ops, using: :gin
    t.index ["npc", "member_count"], name: "index_eve_corporations_on_npc_and_member_count"
  end

  create_table "eve_dogma_attributes", force: :cascade do |t|
    t.bigint "attribute_id"
    t.float "default_value"
    t.string "description"
    t.string "display_name"
    t.boolean "high_is_good"
    t.bigint "icon_id"
    t.string "name"
    t.boolean "published"
    t.boolean "stackable"
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attribute_id"], name: "index_eve_dogma_attributes_on_attribute_id", unique: true
    t.index ["name"], name: "index_eve_dogma_attributes_on_name"
  end

  create_table "eve_etags", force: :cascade do |t|
    t.text "url", null: false
    t.text "etag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "body"
    t.index ["url"], name: "index_eve_etags_on_url", unique: true
  end

  create_table "eve_factions", force: :cascade do |t|
    t.bigint "faction_id"
    t.bigint "corporation_id"
    t.text "description_en"
    t.boolean "is_unique"
    t.bigint "militia_corporation_id"
    t.string "name_en"
    t.float "size_factor"
    t.bigint "solar_system_id"
    t.integer "station_count"
    t.integer "station_system_count"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.text "description_de"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ru"
    t.string "name_ko"
    t.text "description_ko"
    t.index ["faction_id"], name: "index_eve_factions_on_faction_id", unique: true
  end

  create_table "eve_graphics", force: :cascade do |t|
    t.string "collision_file"
    t.string "graphic_file"
    t.bigint "graphic_id"
    t.string "icon_folder"
    t.string "sof_dna"
    t.string "sof_fation_name"
    t.string "sof_hull_name"
    t.string "sof_race_name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["graphic_id"], name: "index_eve_graphics_on_graphic_id", unique: true
  end

  create_table "eve_groups", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "group_id"
    t.string "name_en"
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_ko"
    t.index ["category_id"], name: "index_eve_groups_on_category_id"
    t.index ["group_id"], name: "index_eve_groups_on_group_id", unique: true
  end

  create_table "eve_icons", force: :cascade do |t|
    t.integer "icon_id"
    t.text "description"
    t.string "icon_file"
    t.boolean "obsolete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["icon_id"], name: "index_eve_icons_on_icon_id", unique: true
  end

  create_table "eve_loyalty_store_offers", force: :cascade do |t|
    t.bigint "offer_id"
    t.bigint "ak_cost"
    t.bigint "isk_cost"
    t.bigint "lp_cost"
    t.bigint "quantity"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "corporation_id"
    t.index ["corporation_id"], name: "index_eve_loyalty_store_offers_on_corporation_id"
  end

  create_table "eve_market_groups", force: :cascade do |t|
    t.text "description_en"
    t.text "description_de"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ru"
    t.text "description_ko"
    t.bigint "market_group_id"
    t.string "name_en"
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.string "name_ko"
    t.bigint "parent_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "icon_id"
    t.boolean "has_types"
    t.index ["market_group_id"], name: "index_eve_market_groups_on_market_group_id", unique: true
    t.index ["parent_group_id"], name: "index_eve_market_groups_on_parent_group_id"
  end

  create_table "eve_moons", force: :cascade do |t|
    t.bigint "moon_id"
    t.string "name"
    t.bigint "system_id"
    t.bigint "planet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["moon_id"], name: "index_eve_moons_on_moon_id", unique: true
    t.index ["planet_id"], name: "index_eve_moons_on_planet_id"
    t.index ["system_id"], name: "index_eve_moons_on_system_id"
  end

  create_table "eve_planets", force: :cascade do |t|
    t.string "name"
    t.bigint "planet_id"
    t.bigint "system_id"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_eve_planets_on_planet_id", unique: true
    t.index ["system_id"], name: "index_eve_planets_on_system_id"
    t.index ["type_id"], name: "index_eve_planets_on_type_id"
  end

  create_table "eve_positions", force: :cascade do |t|
    t.bigint "positionable_id"
    t.string "positionable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "x"
    t.string "y"
    t.string "z"
    t.index ["positionable_id", "positionable_type"], name: "index_eve_positions_on_positionable_id_and_positionable_type", unique: true
  end

  create_table "eve_races", force: :cascade do |t|
    t.bigint "faction_id"
    t.text "description_en"
    t.string "name_en"
    t.bigint "race_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.text "description_de"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ru"
    t.string "name_ko"
    t.text "description_ko"
    t.string "name_zh"
    t.string "name_es"
    t.text "description_zh"
    t.text "description_es"
    t.index ["race_id"], name: "index_eve_races_on_race_id", unique: true
  end

  create_table "eve_regions", force: :cascade do |t|
    t.bigint "region_id"
    t.string "name_en"
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.string "name_ko"
    t.text "description_en"
    t.text "description_de"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ru"
    t.text "description_ko"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_eve_regions_on_region_id", unique: true
  end

  create_table "eve_required_items", force: :cascade do |t|
    t.bigint "eve_loyalty_store_offer_id", null: false
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eve_loyalty_store_offer_id"], name: "index_eve_required_items_on_eve_loyalty_store_offer_id"
  end

  create_table "eve_server_statuses", force: :cascade do |t|
    t.bigint "players"
    t.string "server_version"
    t.datetime "start_time", precision: nil
    t.boolean "vip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eve_stargates", force: :cascade do |t|
    t.string "name"
    t.bigint "stargate_id"
    t.bigint "system_id"
    t.bigint "type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "destination_stargate_id"
    t.bigint "destination_system_id"
    t.index ["destination_stargate_id"], name: "index_eve_stargates_on_destination_stargate_id"
    t.index ["destination_system_id"], name: "index_eve_stargates_on_destination_system_id"
    t.index ["stargate_id"], name: "index_eve_stargates_on_stargate_id", unique: true
    t.index ["system_id"], name: "index_eve_stargates_on_system_id"
  end

  create_table "eve_stars", force: :cascade do |t|
    t.bigint "age"
    t.float "luminosity"
    t.string "name"
    t.bigint "radius"
    t.bigint "solar_system_id"
    t.string "spectral_class"
    t.bigint "temperature"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "star_id"
    t.index ["star_id"], name: "index_eve_stars_on_star_id", unique: true
    t.index ["type_id"], name: "index_eve_stars_on_type_id"
  end

  create_table "eve_stations", force: :cascade do |t|
    t.float "max_dockable_ship_volume"
    t.string "name"
    t.float "office_rental_cost"
    t.bigint "owner"
    t.bigint "race_id"
    t.float "reprocessing_efficiency"
    t.float "reprocessing_stations_take"
    t.string "services", array: true
    t.bigint "station_id"
    t.bigint "system_id"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_eve_stations_on_race_id"
    t.index ["station_id"], name: "index_eve_stations_on_station_id", unique: true
    t.index ["system_id"], name: "index_eve_stations_on_system_id"
    t.index ["type_id"], name: "index_eve_stations_on_type_id"
  end

  create_table "eve_systems", force: :cascade do |t|
    t.bigint "constellation_id"
    t.string "name_en"
    t.string "security_class"
    t.float "security_status"
    t.bigint "star_id"
    t.bigint "system_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.string "name_ko"
    t.index ["constellation_id"], name: "index_eve_systems_on_constellation_id"
    t.index ["star_id"], name: "index_eve_systems_on_star_id"
    t.index ["system_id"], name: "index_eve_systems_on_system_id", unique: true
  end

  create_table "eve_type_dogma_attributes", force: :cascade do |t|
    t.bigint "type_id"
    t.bigint "attribute_id"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attribute_id"], name: "index_eve_type_dogma_attributes_on_attribute_id"
    t.index ["type_id"], name: "index_eve_type_dogma_attributes_on_type_id"
  end

  create_table "eve_type_dogma_effects", force: :cascade do |t|
    t.bigint "type_id"
    t.bigint "effect_id"
    t.boolean "is_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_id"], name: "index_eve_type_dogma_effects_on_type_id"
  end

  create_table "eve_types", force: :cascade do |t|
    t.float "capacity"
    t.text "description_en"
    t.bigint "graphic_id"
    t.bigint "group_id"
    t.bigint "icon_id"
    t.bigint "market_group_id"
    t.float "mass"
    t.string "name_en"
    t.float "packaged_volume"
    t.integer "portion_size"
    t.boolean "published"
    t.float "radius"
    t.bigint "type_id"
    t.float "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description_de"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ru"
    t.text "description_ko"
    t.string "name_de"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ru"
    t.string "name_ko"
    t.float "base_price"
    t.float "adjusted_price"
    t.float "average_price"
    t.bigint "copying_time"
    t.integer "max_production_limit"
    t.bigint "manufacturing_time"
    t.bigint "research_material_time"
    t.bigint "research_time_time"
    t.bigint "invention_time"
    t.boolean "is_blueprint"
    t.boolean "is_manufacturing_item"
    t.string "name_zh"
    t.string "name_es"
    t.text "description_zh"
    t.text "description_es"
    t.index ["graphic_id"], name: "index_eve_types_on_graphic_id"
    t.index ["group_id"], name: "index_eve_types_on_group_id"
    t.index ["icon_id"], name: "index_eve_types_on_icon_id"
    t.index ["market_group_id"], name: "index_eve_types_on_market_group_id"
    t.index ["name_en"], name: "index_eve_types_on_name_en", opclass: :gin_trgm_ops, using: :gin
    t.index ["type_id"], name: "index_eve_types_on_type_id", unique: true
  end

  create_table "eve_units", force: :cascade do |t|
    t.text "description"
    t.string "unit_name"
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eve_wars", force: :cascade do |t|
    t.bigint "war_id"
    t.datetime "declared", precision: nil
    t.datetime "finished", precision: nil
    t.boolean "mutual"
    t.boolean "open_for_allies"
    t.datetime "retracted", precision: nil
    t.datetime "started", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["war_id"], name: "index_eve_wars_on_war_id", unique: true
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "industry_jobs", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "activity_id"
    t.bigint "blueprint_id"
    t.bigint "blueprint_location_id"
    t.bigint "blueprint_type_id"
    t.bigint "completed_character_id"
    t.datetime "completed_date", precision: nil
    t.float "cost"
    t.integer "duration"
    t.datetime "end_date", precision: nil
    t.bigint "facility_id"
    t.bigint "installer_id"
    t.bigint "job_id"
    t.integer "licensed_runs"
    t.bigint "output_location_id"
    t.datetime "pause_date", precision: nil
    t.float "probability"
    t.integer "product_type_id"
    t.integer "runs"
    t.datetime "start_date", precision: nil
    t.bigint "station_id"
    t.string "status"
    t.integer "successful_runs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_industry_jobs_on_character_id"
  end

  create_table "loyalty_points", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "corporation_id"
    t.integer "loyalty_points"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["character_id", "corporation_id"], name: "index_loyalty_points_on_character_id_and_corporation_id", unique: true
  end

  create_table "manufacturing_jobs", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "name"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_manufacturing_jobs_on_character_id"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "pghero_query_stats", force: :cascade do |t|
    t.text "database"
    t.text "user"
    t.text "query"
    t.bigint "query_hash"
    t.float "total_time"
    t.bigint "calls"
    t.datetime "captured_at", precision: nil
    t.index ["database", "captured_at"], name: "index_pghero_query_stats_on_database_and_captured_at"
  end

  create_table "pghero_space_stats", force: :cascade do |t|
    t.text "database"
    t.text "schema"
    t.text "relation"
    t.bigint "size"
    t.datetime "captured_at", precision: nil
    t.index ["database", "captured_at"], name: "index_pghero_space_stats_on_database_and_captured_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "skillqueues", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.datetime "finish_date", precision: nil
    t.integer "finished_level"
    t.integer "level_end_sp"
    t.integer "level_start_sp"
    t.integer "queue_position"
    t.bigint "skill_id"
    t.datetime "start_date", precision: nil
    t.integer "training_start_sp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_skillqueues_on_character_id"
  end

  create_table "standings", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "from_id"
    t.string "from_type"
    t.float "standing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "standingable_id"
    t.string "standingable_type"
    t.index ["character_id"], name: "index_standings_on_character_id"
    t.index ["from_id"], name: "index_standings_on_from_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "notifications_count", default: 0
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "authy_id"
    t.datetime "last_sign_in_with_authy", precision: nil
    t.boolean "authy_enabled", default: false
    t.integer "locale", default: 0
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at", precision: nil
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "wallet_journals", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.float "amount"
    t.float "balance"
    t.bigint "context_id"
    t.string "context_id_type"
    t.datetime "date", precision: nil
    t.string "description"
    t.bigint "first_party_id"
    t.bigint "wallet_journal_id"
    t.text "reason"
    t.string "ref_type"
    t.bigint "second_party_id"
    t.float "tax"
    t.bigint "tax_receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_wallet_journals_on_character_id"
    t.index ["wallet_journal_id"], name: "index_wallet_journals_on_wallet_journal_id"
  end

  create_table "wallet_transactions", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "client_id"
    t.datetime "date", precision: nil
    t.boolean "is_buy"
    t.boolean "is_personal"
    t.bigint "journal_ref_id"
    t.bigint "location_id"
    t.integer "quantity"
    t.bigint "transaction_id"
    t.bigint "type_id"
    t.float "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_wallet_transactions_on_character_id"
    t.index ["transaction_id"], name: "index_wallet_transactions_on_transaction_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "character_assets", "characters"
  add_foreign_key "character_blueprints", "characters"
  add_foreign_key "character_killmails", "characters"
  add_foreign_key "character_mail_labels", "characters"
  add_foreign_key "character_orders", "characters"
  add_foreign_key "character_scopes", "characters"
  add_foreign_key "character_skills", "characters"
  add_foreign_key "characters", "users"
  add_foreign_key "etags", "characters"
  add_foreign_key "eve_required_items", "eve_loyalty_store_offers"
  add_foreign_key "industry_jobs", "characters"
  add_foreign_key "manufacturing_jobs", "characters"
  add_foreign_key "skillqueues", "characters"
  add_foreign_key "standings", "characters"
  add_foreign_key "wallet_journals", "characters"
  add_foreign_key "wallet_transactions", "characters"
end

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

ActiveRecord::Schema[8.1].define(version: 2026_01_03_161820) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_buffercache"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "sslinfo"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "character_assets", force: :cascade do |t|
    t.bigint "character_id"
    t.datetime "created_at", null: false
    t.boolean "is_blueprint_copy"
    t.boolean "is_singleton"
    t.bigint "item_id"
    t.string "location_flag"
    t.bigint "location_id"
    t.string "location_type"
    t.bigint "quantity"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_assets_on_character_id"
  end

  create_table "character_blueprints", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.bigint "item_id"
    t.string "location_flag"
    t.bigint "location_id"
    t.integer "material_efficiency"
    t.integer "quantity"
    t.integer "runs"
    t.integer "time_efficiency"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_blueprints_on_character_id"
  end

  create_table "character_corporation_histories", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "corporation_id"
    t.datetime "created_at", null: false
    t.boolean "is_deleted"
    t.bigint "record_id"
    t.datetime "start_date", precision: nil
    t.datetime "updated_at", null: false
    t.index ["character_id", "corporation_id"], name: "index_char_corp_histories_on_char_id_and_corp_id"
    t.index ["corporation_id"], name: "index_character_corporation_histories_on_corporation_id"
    t.index ["record_id"], name: "index_character_corporation_histories_on_record_id"
  end

  create_table "character_implants", force: :cascade do |t|
    t.bigint "character_id"
    t.datetime "created_at", null: false
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_implants_on_character_id"
    t.index ["type_id"], name: "index_character_implants_on_type_id"
  end

  create_table "character_killmails", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.string "killmail_hash"
    t.bigint "killmail_id"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_killmails_on_character_id"
    t.index ["killmail_hash"], name: "index_character_killmails_on_killmail_hash", unique: true
    t.index ["killmail_id"], name: "index_character_killmails_on_killmail_id", unique: true
  end

  create_table "character_mail_labels", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "color"
    t.datetime "created_at", null: false
    t.integer "label_id"
    t.string "name"
    t.integer "unread_count"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_mail_labels_on_character_id"
  end

  create_table "character_orders", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
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
    t.datetime "updated_at", null: false
    t.integer "volume_remain"
    t.integer "volume_total"
    t.index ["character_id"], name: "index_character_orders_on_character_id"
  end

  create_table "character_scopes", force: :cascade do |t|
    t.string "access_token"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.text "esi_last_error"
    t.datetime "esi_token_invalid_at", precision: nil
    t.boolean "esi_token_valid", default: true
    t.string "refresh_token"
    t.string "scope", null: false
    t.boolean "token_expires"
    t.datetime "token_expires_at", precision: nil
    t.string "token_type"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_scopes_on_character_id"
  end

  create_table "character_skills", force: :cascade do |t|
    t.integer "active_skill_level"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.integer "skill_id"
    t.integer "skillpoints_in_skill"
    t.integer "trained_skill_level"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_skills_on_character_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "access_token"
    t.datetime "accrued_remap_cooldown_date", precision: nil
    t.bigint "alliance_id"
    t.datetime "birthday", precision: nil
    t.bigint "bloodline_id"
    t.integer "bonus_remaps"
    t.bigint "character_id"
    t.string "character_owner_hash"
    t.integer "charisma"
    t.bigint "corporation_id"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "current_ship_item_id"
    t.string "current_ship_name"
    t.bigint "current_ship_type_id"
    t.bigint "current_solar_system_id"
    t.bigint "current_station_id"
    t.bigint "current_structure_id"
    t.text "description"
    t.text "esi_last_error"
    t.datetime "esi_token_invalid_at", precision: nil
    t.boolean "esi_token_valid", default: true
    t.bigint "faction_id"
    t.string "gender"
    t.integer "intelligence"
    t.datetime "last_clone_jump_date", precision: nil
    t.datetime "last_remap_date", precision: nil
    t.datetime "last_station_change_date", precision: nil
    t.integer "memory"
    t.string "name"
    t.boolean "online"
    t.integer "perception"
    t.bigint "race_id"
    t.string "refresh_token"
    t.text "scopes"
    t.decimal "security_status", precision: 18, scale: 16
    t.string "title"
    t.boolean "token_expires"
    t.datetime "token_expires_at", precision: nil
    t.string "token_type"
    t.bigint "total_sp"
    t.integer "total_unread_count", default: 0
    t.bigint "unallocated_sp"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.float "wallet"
    t.integer "willpower"
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

  create_table "eve_agents", force: :cascade do |t|
    t.bigint "agent_type_id"
    t.bigint "corporation_id"
    t.datetime "created_at", null: false
    t.bigint "division_id"
    t.boolean "is_locator"
    t.integer "level"
    t.bigint "location_id"
    t.string "name"
    t.integer "quality"
    t.datetime "updated_at", null: false
    t.index ["agent_type_id"], name: "index_eve_agents_on_agent_type_id"
    t.index ["corporation_id"], name: "index_eve_agents_on_corporation_id"
    t.index ["division_id"], name: "index_eve_agents_on_division_id"
    t.index ["location_id"], name: "index_eve_agents_on_location_id"
  end

  create_table "eve_alliances", force: :cascade do |t|
    t.bigint "characters_count", default: 0
    t.integer "corporations_count", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.bigint "creator_corporation_id"
    t.bigint "creator_id"
    t.datetime "date_founded", precision: nil
    t.bigint "executor_corporation_id"
    t.bigint "faction_id"
    t.string "name"
    t.string "ticker"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["characters_count"], name: "index_eve_alliances_on_characters_count"
    t.index ["creator_corporation_id"], name: "index_eve_alliances_on_creator_corporation_id"
    t.index ["creator_id"], name: "index_eve_alliances_on_creator_id"
    t.index ["executor_corporation_id"], name: "index_eve_alliances_on_executor_corporation_id"
    t.index ["faction_id"], name: "index_eve_alliances_on_faction_id"
    t.index ["name", "ticker"], name: "index_eve_alliances_on_name_and_ticker", opclass: :gin_trgm_ops, using: :gin
    t.index ["name"], name: "index_eve_alliances_on_name"
  end

  create_table "eve_ancestries", force: :cascade do |t|
    t.bigint "bloodline_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "description_de"
    t.text "description_en"
    t.text "description_es"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ko"
    t.text "description_zh"
    t.integer "icon_id"
    t.string "name_de"
    t.string "name_en"
    t.string "name_es"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_zh"
    t.text "short_description"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "eve_asteroid_belts", force: :cascade do |t|
    t.bigint "asteroid_belt_id"
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "planet_id"
    t.bigint "system_id"
    t.datetime "updated_at", null: false
    t.index ["asteroid_belt_id"], name: "index_eve_asteroid_belts_on_asteroid_belt_id", unique: true
    t.index ["planet_id"], name: "index_eve_asteroid_belts_on_planet_id"
    t.index ["system_id"], name: "index_eve_asteroid_belts_on_system_id"
  end

  create_table "eve_bloodlines", force: :cascade do |t|
    t.integer "charisma"
    t.bigint "corporation_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "description_de"
    t.text "description_en"
    t.text "description_es"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ko"
    t.text "description_zh"
    t.integer "intelligence"
    t.integer "memory"
    t.string "name_de"
    t.string "name_en"
    t.string "name_es"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_zh"
    t.integer "perception"
    t.bigint "race_id"
    t.bigint "ship_type_id"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "willpower"
  end

  create_table "eve_blueprint_invention_materials", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.datetime "created_at", null: false
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_invention_materials_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_invention_materials_on_type_id"
  end

  create_table "eve_blueprint_invention_products", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.datetime "created_at", null: false
    t.float "probability"
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_invention_products_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_invention_products_on_type_id"
  end

  create_table "eve_blueprint_invention_skills", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.datetime "created_at", null: false
    t.integer "level"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_invention_skills_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_invention_skills_on_type_id"
  end

  create_table "eve_blueprint_manufacturing_materials", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.datetime "created_at", null: false
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_manufacturing_materials_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_manufacturing_materials_on_type_id"
  end

  create_table "eve_blueprint_manufacturing_products", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.datetime "created_at", null: false
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_manufacturing_products_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_manufacturing_products_on_type_id"
  end

  create_table "eve_blueprint_manufacturing_skills", force: :cascade do |t|
    t.bigint "blueprint_id"
    t.datetime "created_at", null: false
    t.integer "level"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_eve_blueprint_manufacturing_skills_on_blueprint_id"
    t.index ["type_id"], name: "index_eve_blueprint_manufacturing_skills_on_type_id"
  end

  create_table "eve_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name_de"
    t.string "name_en"
    t.string "name_es"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_zh"
    t.boolean "published"
    t.datetime "updated_at", null: false
  end

  create_table "eve_certificate_recommended_types", force: :cascade do |t|
    t.bigint "certificate_id"
    t.datetime "created_at", null: false
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["certificate_id"], name: "index_eve_certificate_recommended_types_on_certificate_id"
  end

  create_table "eve_certificate_skills", force: :cascade do |t|
    t.bigint "certificate_id"
    t.datetime "created_at", null: false
    t.integer "level"
    t.integer "skill_level"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["certificate_id"], name: "index_eve_certificate_skills_on_certificate_id"
  end

  create_table "eve_certificates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "group_id"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "eve_character_attributes", force: :cascade do |t|
    t.integer "attribute_id"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "icon_id"
    t.string "name_de"
    t.string "name_en"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_ru"
    t.text "notes"
    t.text "short_description"
    t.datetime "updated_at", null: false
  end

  create_table "eve_character_corporation_histories", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "corporation_id"
    t.datetime "created_at", null: false
    t.boolean "is_deleted"
    t.bigint "record_id"
    t.datetime "start_date", precision: nil
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
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.bigint "faction_id"
    t.string "gender"
    t.string "name"
    t.bigint "race_id"
    t.float "security_status"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["alliance_id"], name: "index_eve_characters_on_alliance_id"
    t.index ["bloodline_id"], name: "index_eve_characters_on_bloodline_id"
    t.index ["corporation_id"], name: "index_eve_characters_on_corporation_id"
    t.index ["faction_id"], name: "index_eve_characters_on_faction_id"
    t.index ["name"], name: "index_eve_characters_on_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["name"], name: "index_eve_characters_on_name_2"
    t.index ["race_id"], name: "index_eve_characters_on_race_id"
  end

  create_table "eve_constellations", force: :cascade do |t|
    t.bigint "constellation_id"
    t.datetime "created_at", null: false
    t.string "name_de"
    t.string "name_en"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_ru"
    t.bigint "region_id"
    t.datetime "updated_at", null: false
    t.index ["constellation_id"], name: "index_eve_constellations_on_constellation_id", unique: true
    t.index ["region_id"], name: "index_eve_constellations_on_region_id"
  end

  create_table "eve_contracts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "buyout"
    t.float "collateral"
    t.bigint "contract_id"
    t.datetime "created_at", null: false
    t.datetime "date_expired", precision: nil
    t.datetime "date_issued", precision: nil
    t.integer "days_to_complete"
    t.bigint "end_location_id"
    t.boolean "for_corporation"
    t.bigint "issuer_corporation_id"
    t.bigint "issuer_id"
    t.string "kind"
    t.float "price"
    t.bigint "region_id"
    t.float "reward"
    t.bigint "start_location_id"
    t.string "title"
    t.datetime "updated_at", null: false
    t.float "volume"
  end

  create_table "eve_corporation_alliance_histories", force: :cascade do |t|
    t.bigint "alliance_id"
    t.bigint "corporation_id"
    t.datetime "created_at", null: false
    t.boolean "is_deleted"
    t.bigint "record_id"
    t.datetime "start_date", precision: nil
    t.datetime "updated_at", null: false
    t.index ["alliance_id"], name: "index_eve_corporation_alliance_histories_on_alliance_id"
    t.index ["corporation_id"], name: "index_eve_corporation_alliance_histories_on_corporation_id"
    t.index ["record_id"], name: "index_eve_corporation_alliance_histories_on_record_id"
  end

  create_table "eve_corporations", force: :cascade do |t|
    t.bigint "alliance_id"
    t.bigint "ceo_id"
    t.text "corporation_url"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "creator_id"
    t.datetime "date_founded", precision: nil
    t.text "description"
    t.bigint "faction_id"
    t.bigint "home_station_id"
    t.integer "member_count"
    t.string "name"
    t.boolean "npc", default: false
    t.bigint "shares"
    t.float "tax_rate"
    t.string "ticker"
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "war_eligible"
    t.index ["alliance_id"], name: "index_eve_corporations_on_alliance_id"
    t.index ["ceo_id"], name: "index_eve_corporations_on_ceo_id"
    t.index ["creator_id"], name: "index_eve_corporations_on_creator_id"
    t.index ["faction_id"], name: "index_eve_corporations_on_faction_id"
    t.index ["home_station_id"], name: "index_eve_corporations_on_home_station_id"
    t.index ["member_count"], name: "index_eve_corporations_on_member_count"
    t.index ["name", "ticker"], name: "index_eve_corporations_on_name_and_ticker", opclass: :gin_trgm_ops, using: :gin
    t.index ["name"], name: "index_eve_corporations_on_name"
    t.index ["npc", "member_count"], name: "index_eve_corporations_on_npc_and_member_count"
  end

  create_table "eve_divisions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.text "description_full_de"
    t.text "description_full_en"
    t.text "description_full_fr"
    t.text "description_full_ja"
    t.text "description_full_ko"
    t.text "description_full_ru"
    t.text "description_full_zh"
    t.string "internal_name"
    t.string "leader_type_name_de"
    t.string "leader_type_name_en"
    t.string "leader_type_name_fr"
    t.string "leader_type_name_ja"
    t.string "leader_type_name_ko"
    t.string "leader_type_name_ru"
    t.string "leader_type_name_zh"
    t.string "name_de"
    t.string "name_en"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_ru"
    t.string "name_zh"
    t.datetime "updated_at", null: false
  end

  create_table "eve_dogma_attributes", force: :cascade do |t|
    t.bigint "attribute_id"
    t.datetime "created_at", null: false
    t.float "default_value"
    t.string "description"
    t.string "display_name"
    t.boolean "high_is_good"
    t.bigint "icon_id"
    t.string "name"
    t.boolean "published"
    t.boolean "stackable"
    t.bigint "unit_id"
    t.datetime "updated_at", null: false
    t.index ["attribute_id"], name: "index_eve_dogma_attributes_on_attribute_id", unique: true
    t.index ["name"], name: "index_eve_dogma_attributes_on_name"
  end

  create_table "eve_factions", force: :cascade do |t|
    t.bigint "corporation_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "description_de"
    t.text "description_en"
    t.text "description_es"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ko"
    t.text "description_zh"
    t.boolean "is_unique"
    t.bigint "militia_corporation_id"
    t.string "name_de"
    t.string "name_en"
    t.string "name_es"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_zh"
    t.float "size_factor"
    t.bigint "solar_system_id"
    t.integer "station_count"
    t.integer "station_system_count"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "eve_graphics", force: :cascade do |t|
    t.string "collision_file"
    t.datetime "created_at", precision: nil, null: false
    t.string "graphic_file"
    t.bigint "graphic_id"
    t.string "icon_folder"
    t.string "sof_dna"
    t.string "sof_fation_name"
    t.string "sof_hull_name"
    t.string "sof_race_name"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["graphic_id"], name: "index_eve_graphics_on_graphic_id", unique: true
  end

  create_table "eve_groups", force: :cascade do |t|
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.string "name_de"
    t.string "name_en"
    t.string "name_es"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_zh"
    t.boolean "published"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_eve_groups_on_category_id"
  end

  create_table "eve_icons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "icon_file"
    t.integer "icon_id"
    t.boolean "obsolete"
    t.datetime "updated_at", null: false
    t.index ["icon_id"], name: "index_eve_icons_on_icon_id", unique: true
  end

  create_table "eve_loyalty_store_offers", force: :cascade do |t|
    t.bigint "ak_cost"
    t.bigint "corporation_id"
    t.datetime "created_at", null: false
    t.bigint "isk_cost"
    t.bigint "lp_cost"
    t.bigint "offer_id"
    t.bigint "quantity"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["corporation_id"], name: "index_eve_loyalty_store_offers_on_corporation_id"
  end

  create_table "eve_market_groups", force: :cascade do |t|
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.text "description_de"
    t.text "description_en"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ko"
    t.text "description_ru"
    t.boolean "has_types"
    t.bigint "icon_id"
    t.bigint "market_group_id"
    t.string "name_de"
    t.string "name_en"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_ru"
    t.bigint "parent_group_id"
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_eve_market_groups_on_ancestry"
    t.index ["market_group_id"], name: "index_eve_market_groups_on_market_group_id", unique: true
    t.index ["parent_group_id"], name: "index_eve_market_groups_on_parent_group_id"
  end

  create_table "eve_moons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "moon_id"
    t.string "name"
    t.bigint "planet_id"
    t.bigint "system_id"
    t.datetime "updated_at", null: false
    t.index ["moon_id"], name: "index_eve_moons_on_moon_id", unique: true
    t.index ["planet_id"], name: "index_eve_moons_on_planet_id"
    t.index ["system_id"], name: "index_eve_moons_on_system_id"
  end

  create_table "eve_planets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "planet_id"
    t.bigint "system_id"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_eve_planets_on_planet_id", unique: true
    t.index ["system_id"], name: "index_eve_planets_on_system_id"
    t.index ["type_id"], name: "index_eve_planets_on_type_id"
  end

  create_table "eve_positions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "positionable_id"
    t.string "positionable_type"
    t.datetime "updated_at", null: false
    t.string "x"
    t.string "y"
    t.string "z"
    t.index ["positionable_id", "positionable_type"], name: "index_eve_positions_on_positionable_id_and_positionable_type", unique: true
  end

  create_table "eve_races", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description_de"
    t.text "description_en"
    t.text "description_es"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ko"
    t.text "description_zh"
    t.bigint "faction_id"
    t.string "name_de"
    t.string "name_en"
    t.string "name_es"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_zh"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "eve_regions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description_de"
    t.text "description_en"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ko"
    t.text "description_ru"
    t.string "name_de"
    t.string "name_en"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_ru"
    t.bigint "region_id"
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_eve_regions_on_region_id", unique: true
  end

  create_table "eve_required_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "eve_loyalty_store_offer_id", null: false
    t.integer "quantity"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["eve_loyalty_store_offer_id"], name: "index_eve_required_items_on_eve_loyalty_store_offer_id"
  end

  create_table "eve_server_statuses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "players"
    t.string "server_version"
    t.datetime "start_time", precision: nil
    t.datetime "updated_at", null: false
    t.boolean "vip"
  end

  create_table "eve_stargates", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "destination_stargate_id"
    t.bigint "destination_system_id"
    t.string "name"
    t.bigint "stargate_id"
    t.bigint "system_id"
    t.bigint "type_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["destination_stargate_id"], name: "index_eve_stargates_on_destination_stargate_id"
    t.index ["destination_system_id"], name: "index_eve_stargates_on_destination_system_id"
    t.index ["stargate_id"], name: "index_eve_stargates_on_stargate_id", unique: true
    t.index ["system_id"], name: "index_eve_stargates_on_system_id"
  end

  create_table "eve_stars", force: :cascade do |t|
    t.bigint "age"
    t.datetime "created_at", null: false
    t.float "luminosity"
    t.string "name"
    t.bigint "radius"
    t.bigint "solar_system_id"
    t.string "spectral_class"
    t.bigint "star_id"
    t.bigint "temperature"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["star_id"], name: "index_eve_stars_on_star_id", unique: true
    t.index ["type_id"], name: "index_eve_stars_on_type_id"
  end

  create_table "eve_stations", force: :cascade do |t|
    t.datetime "created_at", null: false
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
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_eve_stations_on_race_id"
    t.index ["station_id"], name: "index_eve_stations_on_station_id", unique: true
    t.index ["system_id"], name: "index_eve_stations_on_system_id"
    t.index ["type_id"], name: "index_eve_stations_on_type_id"
  end

  create_table "eve_systems", force: :cascade do |t|
    t.bigint "constellation_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "name_de"
    t.string "name_en"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_ru"
    t.string "security_class"
    t.float "security_status"
    t.bigint "star_id"
    t.bigint "system_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["constellation_id"], name: "index_eve_systems_on_constellation_id"
    t.index ["star_id"], name: "index_eve_systems_on_star_id"
    t.index ["system_id"], name: "index_eve_systems_on_system_id", unique: true
  end

  create_table "eve_type_dogma_attributes", force: :cascade do |t|
    t.bigint "attribute_id"
    t.datetime "created_at", null: false
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.float "value"
    t.index ["attribute_id"], name: "index_eve_type_dogma_attributes_on_attribute_id"
    t.index ["type_id"], name: "index_eve_type_dogma_attributes_on_type_id"
  end

  create_table "eve_type_dogma_effects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "effect_id"
    t.boolean "is_default"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.index ["type_id"], name: "index_eve_type_dogma_effects_on_type_id"
  end

  create_table "eve_types", force: :cascade do |t|
    t.float "adjusted_price"
    t.float "average_price"
    t.float "base_price"
    t.float "capacity"
    t.bigint "copying_time"
    t.datetime "created_at", null: false
    t.text "description_de"
    t.text "description_en"
    t.text "description_es"
    t.text "description_fr"
    t.text "description_ja"
    t.text "description_ko"
    t.text "description_ru"
    t.text "description_zh"
    t.bigint "graphic_id"
    t.bigint "group_id"
    t.bigint "icon_id"
    t.bigint "invention_time"
    t.boolean "is_blueprint"
    t.boolean "is_manufacturing_item"
    t.bigint "manufacturing_time"
    t.bigint "market_group_id"
    t.float "mass"
    t.integer "max_production_limit"
    t.string "name_de"
    t.string "name_en"
    t.string "name_es"
    t.string "name_fr"
    t.string "name_ja"
    t.string "name_ko"
    t.string "name_ru"
    t.string "name_zh"
    t.float "packaged_volume"
    t.integer "portion_size"
    t.boolean "published"
    t.float "radius"
    t.bigint "research_material_time"
    t.bigint "research_time_time"
    t.bigint "type_id"
    t.datetime "updated_at", null: false
    t.float "volume"
    t.index ["graphic_id"], name: "index_eve_types_on_graphic_id"
    t.index ["group_id"], name: "index_eve_types_on_group_id"
    t.index ["icon_id"], name: "index_eve_types_on_icon_id"
    t.index ["market_group_id"], name: "index_eve_types_on_market_group_id"
    t.index ["name_en"], name: "index_eve_types_on_name_en", opclass: :gin_trgm_ops, using: :gin
    t.index ["type_id"], name: "index_eve_types_on_type_id", unique: true
  end

  create_table "eve_units", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "display_name"
    t.string "unit_name"
    t.datetime "updated_at", null: false
  end

  create_table "eve_wars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "declared", precision: nil
    t.datetime "finished", precision: nil
    t.boolean "mutual"
    t.boolean "open_for_allies"
    t.datetime "retracted", precision: nil
    t.datetime "started", precision: nil
    t.datetime "updated_at", null: false
    t.bigint "war_id"
    t.index ["war_id"], name: "index_eve_wars_on_war_id", unique: true
  end

  create_table "flipper_features", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "key", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "feature_key", null: false
    t.string "key", null: false
    t.datetime "updated_at", null: false
    t.text "value"
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "industry_jobs", force: :cascade do |t|
    t.bigint "activity_id"
    t.bigint "blueprint_id"
    t.bigint "blueprint_location_id"
    t.bigint "blueprint_type_id"
    t.bigint "character_id", null: false
    t.bigint "completed_character_id"
    t.datetime "completed_date", precision: nil
    t.float "cost"
    t.datetime "created_at", null: false
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
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_industry_jobs_on_character_id"
  end

  create_table "loyalty_points", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "corporation_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "loyalty_points"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["character_id", "corporation_id"], name: "index_loyalty_points_on_character_id_and_corporation_id", unique: true
  end

  create_table "maintenance_tasks_runs", force: :cascade do |t|
    t.text "arguments"
    t.text "backtrace"
    t.datetime "created_at", null: false
    t.string "cursor"
    t.datetime "ended_at", precision: nil
    t.string "error_class"
    t.string "error_message"
    t.string "job_id"
    t.integer "lock_version", default: 0, null: false
    t.text "metadata"
    t.datetime "started_at", precision: nil
    t.string "status", default: "enqueued", null: false
    t.string "task_name", null: false
    t.bigint "tick_count", default: 0, null: false
    t.bigint "tick_total"
    t.float "time_running", default: 0.0, null: false
    t.datetime "updated_at", null: false
    t.index ["task_name", "status", "created_at"], name: "index_maintenance_tasks_runs", order: { created_at: :desc }
  end

  create_table "manufacturing_jobs", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_manufacturing_jobs_on_character_id"
  end

  create_table "noticed_events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "notifications_count"
    t.jsonb "params"
    t.bigint "record_id"
    t.string "record_type"
    t.string "type"
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id"], name: "index_noticed_events_on_record"
  end

  create_table "noticed_notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "event_id", null: false
    t.datetime "read_at", precision: nil
    t.bigint "recipient_id", null: false
    t.string "recipient_type", null: false
    t.datetime "seen_at", precision: nil
    t.string "type"
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_noticed_notifications_on_event_id"
    t.index ["recipient_type", "recipient_id"], name: "index_noticed_notifications_on_recipient"
  end

  create_table "pghero_query_stats", force: :cascade do |t|
    t.bigint "calls"
    t.datetime "captured_at", precision: nil
    t.text "database"
    t.text "query"
    t.bigint "query_hash"
    t.float "total_time"
    t.text "user"
    t.index ["database", "captured_at"], name: "index_pghero_query_stats_on_database_and_captured_at"
  end

  create_table "pghero_space_stats", force: :cascade do |t|
    t.datetime "captured_at", precision: nil
    t.text "database"
    t.text "relation"
    t.text "schema"
    t.bigint "size"
    t.index ["database", "captured_at"], name: "index_pghero_space_stats_on_database_and_captured_at"
  end

  create_table "rails_pulse_operations", force: :cascade do |t|
    t.string "codebase_location", comment: "File and line number (e.g., app/models/user.rb:25)"
    t.datetime "created_at", null: false
    t.decimal "duration", precision: 15, scale: 6, null: false, comment: "Operation duration in milliseconds"
    t.string "label", null: false, comment: "Descriptive name (e.g., SELECT FROM users WHERE id = 1, render layout)"
    t.datetime "occurred_at", precision: nil, null: false, comment: "When the request started"
    t.string "operation_type", null: false, comment: "Type of operation (e.g., database, view, gem_call)"
    t.bigint "query_id", comment: "Link to the normalized SQL query"
    t.bigint "request_id", null: false, comment: "Link to the request"
    t.float "start_time", default: 0.0, null: false, comment: "Operation start time in milliseconds"
    t.datetime "updated_at", null: false
    t.index ["created_at", "query_id"], name: "idx_operations_for_aggregation"
    t.index ["created_at"], name: "idx_operations_created_at"
    t.index ["occurred_at", "duration", "operation_type"], name: "index_rails_pulse_operations_on_time_duration_type"
    t.index ["occurred_at"], name: "index_rails_pulse_operations_on_occurred_at"
    t.index ["operation_type"], name: "index_rails_pulse_operations_on_operation_type"
    t.index ["query_id", "duration", "occurred_at"], name: "index_rails_pulse_operations_query_performance"
    t.index ["query_id", "occurred_at"], name: "index_rails_pulse_operations_on_query_and_time"
    t.index ["query_id"], name: "index_rails_pulse_operations_on_query_id"
    t.index ["request_id"], name: "index_rails_pulse_operations_on_request_id"
  end

  create_table "rails_pulse_queries", force: :cascade do |t|
    t.datetime "analyzed_at", comment: "When query analysis was last performed"
    t.text "backtrace_analysis", comment: "JSON object with call chain and N+1 detection"
    t.datetime "created_at", null: false
    t.text "explain_plan", comment: "EXPLAIN output from actual SQL execution"
    t.text "index_recommendations", comment: "JSON array of database index recommendations"
    t.text "issues", comment: "JSON array of detected performance issues"
    t.text "metadata", comment: "JSON object containing query complexity metrics"
    t.text "n_plus_one_analysis", comment: "JSON object with enhanced N+1 query detection results"
    t.string "normalized_sql", limit: 1000, null: false, comment: "Normalized SQL query string (e.g., SELECT * FROM users WHERE id = ?)"
    t.text "query_stats", comment: "JSON object with query characteristics analysis"
    t.text "suggestions", comment: "JSON array of optimization recommendations"
    t.text "tags", comment: "JSON array of tags for filtering and categorization"
    t.datetime "updated_at", null: false
    t.index ["normalized_sql"], name: "index_rails_pulse_queries_on_normalized_sql", unique: true
  end

  create_table "rails_pulse_requests", force: :cascade do |t|
    t.string "controller_action", comment: "Controller and action handling the request (e.g., PostsController#show)"
    t.datetime "created_at", null: false
    t.decimal "duration", precision: 15, scale: 6, null: false, comment: "Total request duration in milliseconds"
    t.boolean "is_error", default: false, null: false, comment: "True if status >= 500"
    t.datetime "occurred_at", precision: nil, null: false, comment: "When the request started"
    t.string "request_uuid", null: false, comment: "Unique identifier for the request (e.g., UUID)"
    t.bigint "route_id", null: false, comment: "Link to the route"
    t.integer "status", null: false, comment: "HTTP status code (e.g., 200, 500)"
    t.text "tags", comment: "JSON array of tags for filtering and categorization"
    t.datetime "updated_at", null: false
    t.index ["created_at", "route_id"], name: "idx_requests_for_aggregation"
    t.index ["created_at"], name: "idx_requests_created_at"
    t.index ["occurred_at"], name: "index_rails_pulse_requests_on_occurred_at"
    t.index ["request_uuid"], name: "index_rails_pulse_requests_on_request_uuid", unique: true
    t.index ["route_id", "occurred_at"], name: "index_rails_pulse_requests_on_route_id_and_occurred_at"
    t.index ["route_id"], name: "index_rails_pulse_requests_on_route_id"
  end

  create_table "rails_pulse_routes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "method", null: false, comment: "HTTP method (e.g., GET, POST)"
    t.string "path", null: false, comment: "Request path (e.g., /posts/index)"
    t.text "tags", comment: "JSON array of tags for filtering and categorization"
    t.datetime "updated_at", null: false
    t.index ["method", "path"], name: "index_rails_pulse_routes_on_method_and_path", unique: true
  end

  create_table "rails_pulse_summaries", force: :cascade do |t|
    t.float "avg_duration", comment: "Average duration in milliseconds"
    t.integer "count", default: 0, null: false, comment: "Total number of requests/operations"
    t.datetime "created_at", null: false
    t.integer "error_count", default: 0, comment: "Number of error responses (5xx)"
    t.float "max_duration", comment: "Maximum duration in milliseconds"
    t.float "min_duration", comment: "Minimum duration in milliseconds"
    t.float "p50_duration", comment: "50th percentile duration"
    t.float "p95_duration", comment: "95th percentile duration"
    t.float "p99_duration", comment: "99th percentile duration"
    t.datetime "period_end", null: false, comment: "End of the aggregation period"
    t.datetime "period_start", null: false, comment: "Start of the aggregation period"
    t.string "period_type", null: false, comment: "Aggregation period type: hour, day, week, month"
    t.integer "status_2xx", default: 0, comment: "Number of 2xx responses"
    t.integer "status_3xx", default: 0, comment: "Number of 3xx responses"
    t.integer "status_4xx", default: 0, comment: "Number of 4xx responses"
    t.integer "status_5xx", default: 0, comment: "Number of 5xx responses"
    t.float "stddev_duration", comment: "Standard deviation of duration"
    t.integer "success_count", default: 0, comment: "Number of successful responses"
    t.bigint "summarizable_id", null: false, comment: "Link to Route or Query"
    t.string "summarizable_type", null: false
    t.float "total_duration", comment: "Total duration in milliseconds"
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_rails_pulse_summaries_on_created_at"
    t.index ["period_type", "period_start"], name: "index_rails_pulse_summaries_on_period"
    t.index ["summarizable_type", "summarizable_id", "period_type", "period_start"], name: "idx_pulse_summaries_unique", unique: true
    t.index ["summarizable_type", "summarizable_id"], name: "index_rails_pulse_summaries_on_summarizable"
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "value"
    t.string "var", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "skillqueues", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "finish_date", precision: nil
    t.integer "finished_level"
    t.integer "level_end_sp"
    t.integer "level_start_sp"
    t.integer "queue_position"
    t.bigint "skill_id"
    t.datetime "start_date", precision: nil
    t.integer "training_start_sp"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_skillqueues_on_character_id"
  end

  create_table "standings", force: :cascade do |t|
    t.bigint "character_id"
    t.datetime "created_at", null: false
    t.bigint "from_id"
    t.string "from_type"
    t.float "standing"
    t.bigint "standingable_id"
    t.string "standingable_type"
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_standings_on_character_id"
    t.index ["from_id"], name: "index_standings_on_from_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.datetime "confirmation_sent_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.datetime "last_sign_in_at", precision: nil
    t.inet "last_sign_in_ip"
    t.integer "locale", default: 0
    t.integer "notifications_count", default: 0
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.string "unconfirmed_email"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallet_journals", force: :cascade do |t|
    t.float "amount"
    t.float "balance"
    t.bigint "character_id", null: false
    t.bigint "context_id"
    t.string "context_id_type"
    t.datetime "created_at", null: false
    t.datetime "date", precision: nil
    t.string "description"
    t.bigint "first_party_id"
    t.text "reason"
    t.string "ref_type"
    t.bigint "second_party_id"
    t.float "tax"
    t.bigint "tax_receiver_id"
    t.datetime "updated_at", null: false
    t.bigint "wallet_journal_id"
    t.index ["character_id"], name: "index_wallet_journals_on_character_id"
    t.index ["wallet_journal_id"], name: "index_wallet_journals_on_wallet_journal_id"
  end

  create_table "wallet_transactions", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "date", precision: nil
    t.boolean "is_buy"
    t.boolean "is_personal"
    t.bigint "journal_ref_id"
    t.bigint "location_id"
    t.integer "quantity"
    t.bigint "transaction_id"
    t.bigint "type_id"
    t.float "unit_price"
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
  add_foreign_key "eve_required_items", "eve_loyalty_store_offers"
  add_foreign_key "industry_jobs", "characters"
  add_foreign_key "manufacturing_jobs", "characters"
  add_foreign_key "rails_pulse_operations", "rails_pulse_queries", column: "query_id"
  add_foreign_key "rails_pulse_operations", "rails_pulse_requests", column: "request_id"
  add_foreign_key "rails_pulse_requests", "rails_pulse_routes", column: "route_id"
  add_foreign_key "skillqueues", "characters"
  add_foreign_key "standings", "characters"
  add_foreign_key "wallet_journals", "characters"
  add_foreign_key "wallet_transactions", "characters"
end

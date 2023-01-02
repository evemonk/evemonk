# frozen_string_literal: true

FactoryBot.define do
  factory :character do
    user

    name { Faker::Name.name }

    # t.string "access_token"

    # t.string "refresh_token"

    # t.datetime "token_expires_at"

    # t.boolean "token_expires"

    # t.string "token_type"

    birthday { 7.years.ago }

    gender { ["male", "female"].sample }

    description { Faker::Lorem.paragraph }

    security_status { 2.15 }

    wallet { 100.49 }

    charisma { (20..25).to_a.sample }

    intelligence { (20..25).to_a.sample }

    memory { (20..25).to_a.sample }

    perception { (20..25).to_a.sample }

    willpower { (20..25).to_a.sample }

    bonus_remaps { 2 }

    last_remap_date { 6.years.ago }

    accrued_remap_cooldown_date { 5.years.ago }

    sequence(:character_id)

    sequence(:alliance_id)

    sequence(:corporation_id)

    sequence(:race_id)

    sequence(:bloodline_id)

    sequence(:faction_id)

    # t.text "scopes"

    # t.string "character_owner_hash"

    title { "Test title" }

    # t.bigint "current_solar_system_id"
    #
    # t.bigint "current_station_id"
    #
    # t.bigint "current_structure_id"
    #
    # t.bigint "current_ship_item_id"
    #
    # t.string "current_ship_name"
    #
    # t.bigint "current_ship_type_id"
    #
    # t.bigint "total_sp"
    #
    # t.bigint "unallocated_sp"

    esi_token_valid { [true, false].sample }
  end
end

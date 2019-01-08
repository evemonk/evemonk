# frozen_string_literal: true

FactoryBot.define do
  factory :character do
    user

    sequence(:character_id)

    name { Faker::Name.name }

    description { Faker::Lorem.paragraph }

    # t.string "access_token"
    # t.string "refresh_token"
    # t.datetime "token_expires_at"
    # t.boolean "token_expires"
    # t.string "token_type"
    # t.text "scopes"
    # t.string "character_owner_hash"

    birthday { Time.zone.now }

    gender { ['male', 'female'].sample }

    security_status { 2.15 }


    # t.float "wallet"
    # t.integer "charisma"
    # t.integer "intelligence"
    # t.integer "memory"
    # t.integer "perception"
    # t.integer "willpower"
    # t.integer "bonus_remaps"
    # t.datetime "last_remap_date"
    # t.datetime "accrued_remap_cooldown_date"

    sequence(:race_id)

    sequence(:bloodline_id)

    sequence(:faction_id)

    sequence(:ancestry_id)

    sequence(:alliance_id)

    sequence(:corporation_id)
  end
end

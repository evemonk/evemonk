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

    gender { ["male", "female"].sample }

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

    sequence(:race_id)

    sequence(:bloodline_id)

    sequence(:faction_id)

    sequence(:ancestry_id)

    sequence(:alliance_id)

    sequence(:corporation_id)

    title { "Test title" }
  end
end

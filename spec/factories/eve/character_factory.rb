# frozen_string_literal: true

FactoryBot.define do
  factory :eve_character, class: "Eve::Character" do
    sequence(:alliance_id)

    sequence(:ancestry_id)

    birthday { Time.zone.now }

    sequence(:bloodline_id)

    sequence(:corporation_id)

    description { Faker::Lorem.paragraph }

    sequence(:faction_id)

    gender { ["male", "female"].sample }

    name { Faker::Lorem.word }

    sequence(:race_id)

    security_status { 0.0 }

    title { "Test title" }
  end
end

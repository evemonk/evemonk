# frozen_string_literal: true

FactoryBot.define do
  factory :eve_race, class: Eve::Race do
    sequence(:race_id)

    name { Faker::Lorem.word }

    description { Faker::Lorem.paragraph }

    sequence(:alliance_id)
  end
end

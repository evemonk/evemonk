# frozen_string_literal: true

FactoryBot.define do
  factory :eve_race, class: Eve::Race do
    description { Faker::Lorem.paragraph }

    sequence(:race_id)

    name { Faker::Lorem.word }

    sequence(:alliance_id)
  end
end

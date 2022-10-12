# frozen_string_literal: true

FactoryBot.define do
  factory :eve_alliance, class: "Eve::Alliance" do
    sequence(:creator_corporation_id)

    sequence(:creator_id)

    date_founded { Time.zone.now }

    sequence(:executor_corporation_id)

    sequence(:faction_id)

    name { Faker::Lorem.word }

    ticker { Faker::Lorem.word.upcase }
  end
end

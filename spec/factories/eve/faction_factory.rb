# frozen_string_literal: true

FactoryBot.define do
  factory :eve_faction, class: Eve::Faction do
    sequence(:faction_id)

    name { Faker::Lorem.word }

    description { Faker::Lorem.paragraph }

    sequence(:solar_system_id)

    sequence(:corporation_id)

    sequence(:militia_corporation_id)

    size_factor { 1.5 }

    sequence(:station_count)

    sequence(:station_system_count)

    is_unique { [true, false].sample }
  end
end

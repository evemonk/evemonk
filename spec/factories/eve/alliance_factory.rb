# frozen_string_literal: true

FactoryBot.define do
  factory :eve_alliance, class: Eve::Alliance do
    sequence(:alliance_id)

    name { Faker::Lorem.word }

    sequence(:creator_id)

    sequence(:creator_corporation_id)

    ticker { Faker::Lorem.word.upcase }

    sequence(:executor_corporation_id)

    date_founded { Time.zone.now }

    sequence(:faction_id)

    icon_small { "https://imageserver.eveonline.com/Alliance/#{alliance_id}_64.png" }

    icon_medium { "https://imageserver.eveonline.com/Alliance/#{alliance_id}_128.png" }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :eve_corporation, class: "Eve::Corporation" do
    name { Faker::Lorem.word }

    ticker { name.upcase }

    sequence(:member_count)

    sequence(:ceo_id)

    sequence(:alliance_id)

    description { Faker::Lorem.paragraph }

    tax_rate { "0.09" }

    date_founded { Time.zone.now }

    sequence(:creator_id)

    corporation_url { Faker::Internet.url }

    sequence(:faction_id)

    sequence(:home_station_id)

    sequence(:shares)

    war_eligible { [true, false].sample }

    npc { [true, false].sample }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :eve_faction, class: "Eve::Faction" do
    name_en { Faker::Lorem.word }

    name_de { Faker::Lorem.word }

    name_fr { Faker::Lorem.word }

    name_ja { Faker::Lorem.word }

    name_ru { Faker::Lorem.word }

    name_ko { Faker::Lorem.word }

    description_en { Faker::Lorem.paragraph }

    description_de { Faker::Lorem.paragraph }

    description_fr { Faker::Lorem.paragraph }

    description_ja { Faker::Lorem.paragraph }

    description_ru { Faker::Lorem.paragraph }

    description_ko { Faker::Lorem.paragraph }

    sequence(:solar_system_id)

    sequence(:corporation_id)

    sequence(:militia_corporation_id)

    size_factor { 1.5 }

    sequence(:station_count)

    sequence(:station_system_count)

    is_unique { [true, false].sample }
  end
end

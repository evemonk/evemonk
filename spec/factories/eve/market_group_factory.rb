# frozen_string_literal: true

FactoryBot.define do
  factory :eve_market_group, class: "Eve::MarketGroup" do
    description_en { Faker::Lorem.paragraph }

    description_de { Faker::Lorem.paragraph }

    description_fr { Faker::Lorem.paragraph }

    description_ja { Faker::Lorem.paragraph }

    description_ru { Faker::Lorem.paragraph }

    description_ko { Faker::Lorem.paragraph }

    name_en { Faker::Lorem.word }

    name_de { Faker::Lorem.word }

    name_fr { Faker::Lorem.word }

    name_ja { Faker::Lorem.word }

    name_ru { Faker::Lorem.word }

    name_ko { Faker::Lorem.word }

    sequence(:parent_group_id)

    sequence(:icon_id)

    has_types { [true, false].sample }
  end
end

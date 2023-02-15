# frozen_string_literal: true

FactoryBot.define do
  factory :eve_bloodline, class: "Eve::Bloodline" do
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

    sequence(:race_id)

    sequence(:ship_type_id)

    sequence(:corporation_id)

    sequence(:perception)

    sequence(:willpower)

    sequence(:charisma)

    sequence(:memory)

    sequence(:intelligence)
  end
end

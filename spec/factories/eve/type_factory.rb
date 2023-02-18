# frozen_string_literal: true

FactoryBot.define do
  factory :eve_type, class: "Eve::Type" do
    capacity { 1.5 }

    description_en { Faker::Lorem.paragraph }

    description_de { Faker::Lorem.paragraph }

    description_fr { Faker::Lorem.paragraph }

    description_ja { Faker::Lorem.paragraph }

    description_ru { Faker::Lorem.paragraph }

    description_ko { Faker::Lorem.paragraph }

    sequence(:graphic_id)

    sequence(:group_id)

    sequence(:icon_id)

    sequence(:market_group_id)

    mass { 1.5 }

    name_en { Faker::Lorem.word }

    name_de { Faker::Lorem.word }

    name_fr { Faker::Lorem.word }

    name_ja { Faker::Lorem.word }

    name_ru { Faker::Lorem.word }

    name_ko { Faker::Lorem.word }

    packaged_volume { 1.5 }

    portion_size { 1 }

    published { [false, true].sample }

    radius { 1.5 }

    volume { 1.5 }

    is_blueprint { [false, true].sample }

    is_manufacturing_item { [false, true].sample }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :eve_type, class: Eve::Type do
    capacity { 1.5 }

    description { Faker::Lorem.paragraph }

    sequence(:graphic_id)

    sequence(:group_id)

    sequence(:icon_id)

    sequence(:market_group_id)

    mass { 1.5 }

    name { Faker::Lorem.word }

    packaged_volume { 1.5 }

    portion_size { 1 }

    published { [false, true].sample }

    radius { 1.5 }

    sequence(:type_id)

    volume { 1.5 }
  end
end

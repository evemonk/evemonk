# frozen_string_literal: true

FactoryBot.define do
  factory :eve_group, class: Eve::Group do
    sequence(:category_id)

    sequence(:group_id)

    name { Faker::Lorem.word }

    published { [true, false].sample }
  end
end

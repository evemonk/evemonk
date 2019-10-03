# frozen_string_literal: true

FactoryBot.define do
  factory :eve_category, class: Eve::Category do
    sequence(:category_id)

    name { Faker::Lorem.word }

    published { [true, false].sample }
  end
end

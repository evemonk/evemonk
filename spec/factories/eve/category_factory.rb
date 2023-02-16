# frozen_string_literal: true

FactoryBot.define do
  factory :eve_category, class: "Eve::Category" do
    name_en { Faker::Lorem.word }

    name_de { Faker::Lorem.word }

    name_fr { Faker::Lorem.word }

    name_ja { Faker::Lorem.word }

    name_ru { Faker::Lorem.word }

    name_ko { Faker::Lorem.word }

    published { [true, false].sample }
  end
end

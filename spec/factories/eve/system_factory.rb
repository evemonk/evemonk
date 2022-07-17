# frozen_string_literal: true

FactoryBot.define do
  factory :eve_system, class: "Eve::System" do
    sequence(:constellation_id)

    name_en { Faker::Lorem.word }

    name_de { Faker::Lorem.word }

    name_fr { Faker::Lorem.word }

    name_ja { Faker::Lorem.word }

    name_ru { Faker::Lorem.word }

    name_ko { Faker::Lorem.word }

    security_class { "B" }

    security_status { 0.8583240509033203 }

    sequence(:star_id)
  end
end

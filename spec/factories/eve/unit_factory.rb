# frozen_string_literal: true

FactoryBot.define do
  factory :eve_unit, class: "Eve::Unit" do
    description { Faker::Lorem.paragraph }

    unit_name { Faker::Lorem.word }

    display_name { Faker::Lorem.word }
  end
end

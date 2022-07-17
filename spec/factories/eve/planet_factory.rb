# frozen_string_literal: true

FactoryBot.define do
  factory :eve_planet, class: "Eve::Planet" do
    name { Faker::Lorem.word }

    sequence(:system_id)

    sequence(:type_id)
  end
end

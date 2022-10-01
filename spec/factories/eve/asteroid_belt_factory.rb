# frozen_string_literal: true

FactoryBot.define do
  factory :eve_asteroid_belt, class: "Eve::AsteroidBelt" do
    name { Faker::Lorem.word }

    sequence(:system_id)

    sequence(:planet_id)
  end
end

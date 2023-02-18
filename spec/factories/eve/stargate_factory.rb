# frozen_string_literal: true

FactoryBot.define do
  factory :eve_stargate, class: "Eve::Stargate" do
    name { Faker::Lorem.word }

    sequence(:system_id)

    sequence(:type_id)
  end
end

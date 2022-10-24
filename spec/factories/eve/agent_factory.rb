# frozen_string_literal: true

FactoryBot.define do
  factory :eve_agent, class: "Eve::Agent" do
    sequence(:agent_type_id)

    sequence(:corporation_id)

    sequence(:division_id)

    is_locator { [true, false].sample }

    level { [1, 2, 3, 4, 5].sample }

    sequence(:location_id)

    quality { 20 }

    name { Faker::Lorem.word }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :eve_certificate, class: "Eve::Certificate" do
    description { Faker::Lorem.paragraph }

    sequence(:group_id)

    name { Faker::Lorem.word }
  end
end

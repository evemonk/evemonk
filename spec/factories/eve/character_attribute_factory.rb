# frozen_string_literal: true

FactoryBot.define do
  factory :eve_character_attribute, class: Eve::CharacterAttribute do
    sequence(:attribute_id)

    attribute_name { Faker::Lorem.word }

    description { Faker::Lorem.paragraph }

    sequence(:icon_id)

    notes { Faker::Lorem.paragraph }

    short_description { Faker::Lorem.paragraph }
  end
end

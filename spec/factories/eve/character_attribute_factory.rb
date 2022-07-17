# frozen_string_literal: true

FactoryBot.define do
  factory :eve_character_attribute, class: "Eve::CharacterAttribute" do
    name_en { Faker::Lorem.word }

    name_de { Faker::Lorem.word }

    name_fr { Faker::Lorem.word }

    name_ja { Faker::Lorem.word }

    name_ru { Faker::Lorem.word }

    name_ko { Faker::Lorem.word }

    description { Faker::Lorem.paragraph }

    sequence(:icon_id)

    notes { Faker::Lorem.paragraph }

    short_description { Faker::Lorem.paragraph }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :eve_dogma_attribute, class: "Eve::DogmaAttribute" do
    sequence(:attribute_id)

    default_value { 1.5 }

    description { Faker::Lorem.paragraph }

    display_name { Faker::Lorem.word }

    high_is_good { [true, false].sample }

    sequence(:icon_id)

    name { Faker::Lorem.word }

    published { [true, false].sample }

    stackable { [true, false].sample }

    sequence(:unit_id)
  end
end

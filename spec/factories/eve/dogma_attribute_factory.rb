# frozen_string_literal: true

FactoryBot.define do
  factory :eve_dogma_attribute, class: Eve::DogmaAttribute do
    attribute_id { "" }

    default_value { 1.5 }

    description { "MyString" }

    display_name { "MyString" }

    high_is_good { false }

    icon_id { "" }

    name { "MyString" }

    published { false }

    stackable { false }

    unit_id { "" }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :eve_type_dogma_attribute, class: Eve::TypeDogmaAttribute do
    sequence(:type_id)

    sequence(:attribute_id)

    value { 1 }
  end
end

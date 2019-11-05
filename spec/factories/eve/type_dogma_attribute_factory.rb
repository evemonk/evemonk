# frozen_string_literal: true

FactoryBot.define do
  factory :eve_type_dogma_attribute, class: Eve::TypeDogmaAttribute do
    association :type, factory: :eve_type

    sequence(:attribute_id)

    value { 1 }
  end
end

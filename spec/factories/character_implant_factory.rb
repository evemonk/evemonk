# frozen_string_literal: true

FactoryBot.define do
  factory :character_implant do
    character

    sequence(:type_id)
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :eve_type_dogma_effect, class: Eve::TypeDogmaEffect do
    sequence(:type_id) # TODO: replace type_id with factory "type"
    sequence(:effect_id)
    is_default { [true, false].sample }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :character_blueprint do
    character

    sequence(:item_id)

    location_flag { "MyString" } # TODO: fix

    location_id { "" } # TODO: fix

    material_efficiency { 1 }

    quantity { [-2, -1, 1, 100].sample }

    runs { 1 } # TODO: fix

    time_efficiency { 1 } # TODO: fix

    sequence(:type_id)
  end
end

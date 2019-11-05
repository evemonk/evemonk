# frozen_string_literal: true

FactoryBot.define do
  factory :character_asset do
    character

    is_blueprint_copy { [true, false].sample }

    is_singleton { [true, false].sample }

    sequence(:item_id)

    location_flag { "MyString" } # TODO: fix

    location_id { "" } # TODO: fix

    location_type { "MyString" } # TODO: fix

    sequence(:quantity)

    sequence(:type_id)
  end
end

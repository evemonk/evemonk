# frozen_string_literal: true

FactoryBot.define do
  factory :character_asset do
    character

    is_blueprint_copy { [true, false].sample }

    is_singleton { [true, false].sample }

    item_id { "" }
    location_flag { "MyString" }
    location_id { "" }
    location_type { "MyString" }
    quantity { "" }
    type_id { "" }
  end
end

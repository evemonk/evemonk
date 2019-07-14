# frozen_string_literal: true

FactoryBot.define do
  factory :character_asset do
    character_id { "" }
    is_blueprint_copy { false }
    is_singleton { false }
    item_id { "" }
    location_flag { "MyString" }
    location_id { "" }
    location_type { "MyString" }
    quantity { "" }
    type_id { "" }
  end
end

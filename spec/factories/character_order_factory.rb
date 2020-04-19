# frozen_string_literal: true

FactoryBot.define do
  factory :character_order do
    character

    duration { 1 }

    escrow { 1.5 }

    is_buy_order { false }

    is_corporation { false }

    issued { "2020-04-19 00:16:22" }

    location_id { "" }

    min_volume { 1 }

    order_id { "" }

    price { 1.5 }

    range { "MyString" }

    region_id { "" }

    type_id { "" }

    volume_remain { 1 }

    volume_total { 1 }
  end
end

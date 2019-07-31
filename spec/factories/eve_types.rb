# frozen_string_literal: true

FactoryBot.define do
  factory :eve_type, class: "Eve::Type" do
    capacity { 1.5 }
    description { "MyText" }
    graphic_id { "" }
    group_id { "" }
    icon_id { "" }
    market_group_id { "" }
    mass { 1.5 }
    name { "MyString" }
    packaged_volume { 1.5 }
    portion_size { 1 }
    published { false }
    radius { 1.5 }
    type_id { "" }
    volume { 1.5 }
  end
end

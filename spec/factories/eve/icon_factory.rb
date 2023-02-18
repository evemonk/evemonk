# frozen_string_literal: true

FactoryBot.define do
  factory :eve_icon, class: "Eve::Icon" do
    description { Faker::Lorem.paragraph }

    icon_file { "res:/ui/texture/icons/1.png" }

    obsolete { [true, false].sample }
  end
end

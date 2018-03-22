FactoryBot.define do
  factory :eve_ancestry, class: Eve::Ancestry do
    sequence(:ancestry_id)

    name { Faker::Lorem.word }

    sequence(:bloodline_id)

    description { Faker::Lorem.paragraph }

    short_description { Faker::Lorem.sentence }

    sequence(:icon_id)
  end
end

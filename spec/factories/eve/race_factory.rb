FactoryGirl.define do
  factory :eve_race, class: Eve::Race do
    description { Faker::Lorem.paragraph }

    sequence(:race_id)

    race_name { Faker::Lorem.word }

    short_description { Faker::Lorem.sentence }

    sequence(:icon_id)
  end
end

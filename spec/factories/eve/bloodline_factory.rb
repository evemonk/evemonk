FactoryBot.define do
  factory :eve_bloodline, class: Eve::Bloodline do
    name { Faker::Lorem.word }

    description { Faker::Lorem.paragraph }

    sequence(:race_id)

    sequence(:ship_type_id)

    sequence(:corporation_id)

    sequence(:perception)

    sequence(:willpower)

    sequence(:charisma)

    sequence(:memory)

    sequence(:intelligence)
  end
end

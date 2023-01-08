# frozen_string_literal: true

FactoryBot.define do
  factory :eve_division, class: "Eve::Division" do
    description { Faker::Lorem.paragraph }

    description_full_en { Faker::Lorem.paragraph }

    description_full_de { Faker::Lorem.paragraph }

    description_full_fr { Faker::Lorem.paragraph }

    description_full_ja { Faker::Lorem.paragraph }

    description_full_ko { Faker::Lorem.paragraph }

    description_full_ru { Faker::Lorem.paragraph }

    description_full_zh { Faker::Lorem.paragraph }

    internal_name { Faker::Lorem.word }

    leader_type_name_en { Faker::Lorem.word }

    leader_type_name_de { Faker::Lorem.word }

    leader_type_name_fr { Faker::Lorem.word }

    leader_type_name_ja { Faker::Lorem.word }

    leader_type_name_ko { Faker::Lorem.word }

    leader_type_name_ru { Faker::Lorem.word }

    leader_type_name_zh { Faker::Lorem.word }

    name_en { Faker::Lorem.word }

    name_de { Faker::Lorem.word }

    name_fr { Faker::Lorem.word }

    name_ja { Faker::Lorem.word }

    name_ko { Faker::Lorem.word }

    name_ru { Faker::Lorem.word }

    name_zh { Faker::Lorem.word }
  end
end

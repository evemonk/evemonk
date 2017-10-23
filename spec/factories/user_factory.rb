# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    kind :normal
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :oauth do
      kind :oauth
      email nil
      password nil
    end
  end
end

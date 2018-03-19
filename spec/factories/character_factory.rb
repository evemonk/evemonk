# frozen_string_literal: true

FactoryBot.define do
  factory :character do
    user

    sequence(:uid)

    name { Faker::Name.name }

    description { Faker::Lorem.paragraph }

    association :race, factory: :eve_race

    association :bloodline, factory: :eve_bloodline

    association :faction, factory: :eve_faction

    # TODO: later
    # token 'MyString'
    # refresh_token 'MyString'
    # token_expires_at '2017-09-29 22:01:16'
    # token_expires false
  end
end

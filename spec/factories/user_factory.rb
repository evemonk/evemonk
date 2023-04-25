# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }

    password { Faker::Internet.password }

    notifications_count { 0 } # TODO: fix

    confirmed_at { Time.zone.now }

    locale { User.locales.keys.sample }

    admin { [true, false].sample }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }

    password { Faker::Internet.password }

    # reset_password_token { SecureRandom.base58 }

    notifications_count { 0 } # TODO: fix

    confirmed_at { Time.zone.now }

    locale { [User.locales.keys].sample }
  end
end

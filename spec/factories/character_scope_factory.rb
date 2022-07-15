# frozen_string_literal: true

FactoryBot.define do
  factory :character_scope do
    character

    scope { "publicData" }

    access_token { Faker::Internet.device_token }

    refresh_token { Faker::Internet.device_token }

    token_expires_at { 1.day.from_now }

    token_expires { [true, false].sample }

    # TODO: "Corporation"
    token_type { "Character" }
  end
end

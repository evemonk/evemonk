# frozen_string_literal: true

FactoryBot.define do
  factory :character_scope do
    character

    access_token { Faker::Internet.device_token }

    refresh_token { Faker::Internet.device_token }

    token_expires_at { Time.zone.now + 1.day }

    token_expires { [true, false ].sample }

    # TODO: "Corporation"
    token_type { "Character" }
  end
end

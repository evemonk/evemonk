# frozen_string_literal: true

FactoryBot.define do
  sequence :device_token do |n|
    "push-notification-token-#{n}"
  end

  sequence :name do |n|
    "My Device #{n}"
  end

  factory :session do
    user

    token { SecureRandom.base58(24) }

    name

    device_token

    device_type { Session.device_types.keys.sample }
  end
end

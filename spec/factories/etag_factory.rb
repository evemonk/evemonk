# frozen_string_literal: true

FactoryBot.define do
  factory :etag do
    sequence :url do |n|
      "https://esi.evetech.net/v3/alliances/#{n}/"
    end

    etag { SecureRandom.hex }

    body { "" } # TODO: add json example
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :eve_etag, class: "Eve::Etag" do
    sequence :url do |n|
      "https://esi.evetech.net/v3/alliances/#{n}/"
    end

    etag { SecureRandom.hex }

    body { "" } # TODO: add json example
  end
end

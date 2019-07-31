# frozen_string_literal: true

FactoryBot.define do
  factory :eve_etag, class: Eve::Etag do
    sequence :url do |n|
      "https://esi.evetech.net/v3/alliances/#{n}/?datasource=tranquility"
    end

    etag { SecureRandom.hex }
  end
end

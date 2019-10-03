# frozen_string_literal: true

FactoryBot.define do
  factory :eve_alliance_corporation, class: Eve::AllianceCorporation do
    sequence(:alliance_id)

    sequence(:corporation_id)
  end
end

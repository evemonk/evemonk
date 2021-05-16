# frozen_string_literal: true

FactoryBot.define do
  factory :eve_corporation_alliance_history, class: "Eve::CorporationAllianceHistory" do
    association :corporation, factory: :eve_corporation

    sequence(:alliance_id)

    is_deleted { [true, false].sample }

    sequence(:record_id)

    start_date { Time.zone.now }
  end
end

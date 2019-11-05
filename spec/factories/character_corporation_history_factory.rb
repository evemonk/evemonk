# frozen_string_literal: true

FactoryBot.define do
  factory :character_corporation_history do
    character

    sequence(:corporation_id)

    is_deleted { [true, false].sample }

    sequence(:record_id)

    start_date { Time.zone.now }
  end
end

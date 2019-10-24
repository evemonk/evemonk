# frozen_string_literal: true

FactoryBot.define do
  factory :character_corporation_history do
    character

    sequence(:corporation_id)

    is_deleted { false }

    sequence(:record_id)

    start_date { "2019-10-21 23:50:52" }
  end
end

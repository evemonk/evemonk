# frozen_string_literal: true

FactoryBot.define do
  factory :eve_character_corporation_history, class: Eve::CharacterCorporationHistory do
    sequence(:character_id)

    sequence(:corporation_id)

    is_deleted { [true, false].sample }

    sequence(:record_id)

    start_date { Time.zone.now }
  end
end

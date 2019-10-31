# frozen_string_literal: true

FactoryBot.define do
  factory :eve_war, class: Eve::War do
    sequence(:war_id)

    declared { Time.zone.now }

    finished { Time.zone.now + 3.day }

    mutual { [true, false].sample }

    open_for_allies { [true, false].sample }

    retracted { Time.zone.now + 2.day }

    started { Time.zone.now + 1.day }
  end
end

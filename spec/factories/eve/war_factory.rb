# frozen_string_literal: true

FactoryBot.define do
  factory :eve_war, class: "Eve::War" do
    sequence(:war_id)

    declared { Time.zone.now }

    finished { 3.days.from_now }

    mutual { [true, false].sample }

    open_for_allies { [true, false].sample }

    retracted { 2.days.from_now }

    started { 1.day.from_now }
  end
end

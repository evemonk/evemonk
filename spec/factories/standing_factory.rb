# frozen_string_literal: true

FactoryBot.define do
  factory :standing do
    character

    sequence(:from_id)

    from_type { ["agent", "npc_corp", "faction"].sample }

    standing { 1.56789 }

    for_agent

    trait :for_agent do
      association :standingable, factory: :eve_agent
    end

    trait :for_corporation do
      association :standingable, factory: :eve_corporation
    end

    trait :for_faction do
      association :standingable, factory: :eve_faction
    end
  end
end

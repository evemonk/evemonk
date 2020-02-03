# frozen_string_literal: true

FactoryBot.define do
  factory :standing do
    character

    sequence(:from_id)

    standing { 1.56789 }

    for_agent

    trait :for_agent do
      from_type { "agent" }

      association :standingable, factory: :eve_agent
    end

    trait :for_corporation do
      from_type { "npc_corp" }

      association :standingable, factory: :eve_corporation
    end

    trait :for_faction do
      from_type { "faction" }

      association :standingable, factory: :eve_faction
    end
  end
end

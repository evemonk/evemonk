# frozen_string_literal: true

FactoryBot.define do
  factory :standing do
    character

    sequence(:from_id)

    from_type { ["agent", "npc_corp", "faction"].sample }

    standing { 1.56789 }
  end
end

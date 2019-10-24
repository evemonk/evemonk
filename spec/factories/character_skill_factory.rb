# frozen_string_literal: true

FactoryBot.define do
  factory :character_skill do
    character

    active_skill_level { 1 }

    skill_id { 1 }

    skillpoints_in_skill { 1 }

    trained_skill_level { 1 }
  end
end

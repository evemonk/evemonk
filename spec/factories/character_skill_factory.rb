# frozen_string_literal: true

FactoryBot.define do
  factory :character_skill do
    character

    active_skill_level { 1 } # TODO: fix

    skill_id { 1 } # TODO: fix

    skillpoints_in_skill { 1 } # TODO: fix

    trained_skill_level { 1 } # TODO: fix
  end
end

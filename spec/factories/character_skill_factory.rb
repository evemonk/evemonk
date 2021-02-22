# frozen_string_literal: true

FactoryBot.define do
  factory :character_skill do
    character

    active_skill_level { [0, 1, 2, 3, 4, 5].sample }

    skill_id { 1 } # TODO: fix

    skillpoints_in_skill { 1 } # TODO: fix

    trained_skill_level { [0, 1, 2, 3, 4, 5].sample }
  end
end

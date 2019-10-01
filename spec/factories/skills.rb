FactoryBot.define do
  factory :skill do
    character { nil }
    active_skill_level { 1 }
    skill_id { 1 }
    skillpoints_in_skill { 1 }
    trained_skill_level { 1 }
  end
end

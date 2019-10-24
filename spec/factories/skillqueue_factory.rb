# frozen_string_literal: true

FactoryBot.define do
  factory :skillqueue do
    character

    finish_date { "2019-10-02 00:54:40" }

    finished_level { 1 }

    level_end_sp { 1 }

    level_start_sp { 1 }

    queue_position { 1 }

    skill_id { "" }

    start_date { "2019-10-02 00:54:40" }

    training_start_sp { 1 }
  end
end

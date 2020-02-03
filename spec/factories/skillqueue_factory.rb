# frozen_string_literal: true

FactoryBot.define do
  factory :skillqueue do
    character

    finish_date { "2019-10-02 00:54:40" } # TODO: fix

    finished_level { [1, 2, 3, 4, 5].sample }

    level_end_sp { 1 } # TODO: fix

    level_start_sp { 1 } # TODO: fix

    sequence(:queue_position)

    sequence(:skill_id)

    start_date { "2019-10-02 00:54:40" } # TODO: fix

    training_start_sp { 1 } # TODO: fix
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    association :recipient, factory: :character

    type { "" } # TODO: update

    params { "" } # TODO: update

    read_at { "2021-03-04 17:59:23" } # TODO: update
  end
end

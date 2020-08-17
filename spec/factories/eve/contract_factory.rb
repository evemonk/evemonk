# frozen_string_literal: true

FactoryBot.define do
  factory :eve_contract, class: Eve::Contract do
    sequence(:region_id)

    sequence(:contract_id)

    # TODO: update factory
  end
end

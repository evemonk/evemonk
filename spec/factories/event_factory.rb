# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    character

    sequence(:event_id)

    # t.string :text
    # t.string :title
    # t.bigint :owner_id
    # t.string :owner_name
    # t.string :owner_type
    # t.integer :duration
    # t.datetime :event_date
    # t.string :event_response
    # t.integer :importance
  end
end

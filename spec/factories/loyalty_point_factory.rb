FactoryBot.define do
  factory :loyalty_point do
    character

    association :corporation, factory: :eve_corporation

    sequence(:loyalty_points)
  end
end

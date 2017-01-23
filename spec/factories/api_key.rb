FactoryGirl.define do
  sequence :v_code do |n|
    "v_code-#{ n }"
  end

  sequence(:key_id) { |n| n }

  factory :api_key do
    user
    key_id
    v_code
  end
end

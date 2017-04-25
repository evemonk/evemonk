FactoryGirl.define do
  sequence :v_code do |n|
    "verification-code-#{ n }"
  end

  sequence :key_id do |n|
    "#{ n }"
  end

  factory :api_key do
    user
    key_id
    v_code
  end
end

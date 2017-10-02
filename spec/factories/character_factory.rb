FactoryGirl.define do
  factory :character do
    user
    uid 1
    name "MyString"
    token "MyString"
    refresh_token "MyString"
    token_expires_at "2017-09-29 22:01:16"
    token_expires false
  end
end

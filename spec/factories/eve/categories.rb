FactoryBot.define do
  factory :eve_category, class: 'Eve::Category' do
    category_id { "" }
    name { "MyString" }
    published { false }
  end
end

FactoryBot.define do
  factory :eve_group, class: 'Eve::Group' do
    category_id { "" }
    group_id { "" }
    name { "MyString" }
    published { false }
  end
end

class Character < ApplicationRecord
  belongs_to :user

  belongs_to :race, class_name: 'Eve::Race', primary_key: :race_id
end

class Session < ApplicationRecord
  belongs_to :user

  validates :user, presence: true

  has_secure_token
end

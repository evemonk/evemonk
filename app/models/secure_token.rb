class SecureToken < ApplicationRecord
  belongs_to :user

  has_secure_token

  validates :user, presence: true
end

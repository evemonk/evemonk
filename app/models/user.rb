class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  has_many :api_keys, dependent: :destroy
end

class User < ApplicationRecord
  has_many :api_keys, dependent: :destroy

  has_many :sessions, dependent: :destroy

  validates :email, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  has_secure_password
end

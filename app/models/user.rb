class User < ActiveRecord::Base
  has_secure_password

  has_secure_token

  validates :email, presence: true

  validates :email, uniqueness: { case_sensitive: false }
end

class User < ApplicationRecord
  enum kind: [:normal, :oauth]

  has_many :sessions, dependent: :destroy

  has_many :characters, dependent: :destroy

  validates :email, presence: true, unless: :oauth?

  validates :email, uniqueness: { case_sensitive: false }, unless: :oauth?

  has_secure_password validations: false
end

class Session < ApplicationRecord
  enum device: [:ios, :android]

  belongs_to :user

  validates :user, presence: true

  has_secure_token
end

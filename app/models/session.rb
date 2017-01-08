class Session < ApplicationRecord
  enum device: [:ios, :android]

  belongs_to :user

  validates :user, presence: true

  validates :device_token, presence: true, if: :device?

  has_secure_token
end

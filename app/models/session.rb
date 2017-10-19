class Session < ApplicationRecord
  enum device: [:ios, :android]

  belongs_to :user

  validates :device_token, presence: true, if: :device?

  has_secure_token
end

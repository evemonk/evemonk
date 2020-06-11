# frozen_string_literal: true

class Session < ApplicationRecord
  enum device_type: {ios: 0, android: 1}

  belongs_to :user

  validates :device_token, presence: true, if: :device_type?

  has_secure_token
end

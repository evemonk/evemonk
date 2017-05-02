class ApiKey < ApplicationRecord
  enum status: [:fresh, :active, :disabled]

  belongs_to :user

  validates :user, presence: true

  validates :key_id, presence: true

  validates :key_id, numericality: { only_integer: true }

  validates :v_code, presence: true
end

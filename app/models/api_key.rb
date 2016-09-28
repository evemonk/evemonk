class ApiKey < ApplicationRecord
  belongs_to :user

  validates :user, presence: true

  validates :key_id, presence: true

  validates :key_id, numericality: { only_integer: true }

  validates :v_code, presence: true

  after_commit :validate_api_key, on: [:create, :update]

  private

  def validate_api_key
    ValidateApiKeyJob.perform_later(id)
  end
end

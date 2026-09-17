# frozen_string_literal: true

class CharacterScope < ApplicationRecord
  belongs_to :character

  validates :scope, presence: true

  scope :with_valid_tokens, -> { where(esi_token_valid: true) }

  scope :with_invalid_tokens, -> { where(esi_token_valid: false) }

  def token_expired?
    token_expires_at <= Time.zone.now
  end
end

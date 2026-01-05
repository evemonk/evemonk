# frozen_string_literal: true

class CharacterScope < ApplicationRecord
  belongs_to :character

  validates :scope, presence: true

  def token_expired?
    token_expires_at <= Time.zone.now
  end
end

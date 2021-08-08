# frozen_string_literal: true

class CharacterScope < ApplicationRecord
  belongs_to :character

  def token_expired?
    token_expires_at <= Time.zone.now
  end
end

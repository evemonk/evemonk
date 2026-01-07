# frozen_string_literal: true

class CharacterScope < ApplicationRecord
  belongs_to :character

  validates :scope, presence: true

  scope :with_valid_tokens, -> { all }

  # describe ".with_valid_tokens" do
  #   let!(:character_1) { create(:character, esi_token_valid: true) }
  #
  #   let!(:character_2) { create(:character, esi_token_valid: false) }
  #
  #   specify { expect(described_class.with_valid_tokens).to eq([character_1]) }
  # end

  def token_expired?
    token_expires_at <= Time.zone.now
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe Api::RefreshCharacterAccessToken do
  context 'when token fresh' do
    let(:character) do
      create(:character,
             token_expires_at: Time.zone.now + 1.day)
    end

    subject { described_class.new(character.character_id) }

    before { expect(character).not_to receive(:update!) }

    specify { expect { subject.refresh }.not_to raise_error }
  end

  context 'when token needed to refresh' do
  end
end

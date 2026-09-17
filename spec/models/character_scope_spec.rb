# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterScope, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to belong_to(:character) }

  it { expect(subject).to validate_presence_of(:scope) }

  describe ".with_valid_tokens" do
    let!(:character) { create(:character) }

    let!(:character_scope_1) { create(:character_scope, character: character, esi_token_valid: true) }

    let!(:character_scope_2) { create(:character_scope, character: character, esi_token_valid: false) }

    specify { expect(described_class.with_valid_tokens).to eq([character_scope_1]) }
  end

  describe ".with_invalid_tokens" do
    let!(:character) { create(:character) }

    let!(:character_scope_1) { create(:character_scope, character: character, esi_token_valid: true) }

    let!(:character_scope_2) { create(:character_scope, character: character, esi_token_valid: false) }

    specify { expect(described_class.with_invalid_tokens).to eq([character_scope_2]) }
  end

  describe "#token_expired?" do
    context "when expired" do
      subject { build(:character_scope, token_expires_at: 1.hour.ago) }

      specify { expect(subject.token_expired?).to eq(true) }
    end

    context "when not expired" do
      subject { build(:character_scope, token_expires_at: 1.hour.from_now) }

      specify { expect(subject.token_expired?).to eq(false) }
    end
  end
end

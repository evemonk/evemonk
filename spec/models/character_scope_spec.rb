# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterScope, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to belong_to(:character) }

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

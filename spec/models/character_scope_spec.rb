# frozen_string_literal: true

require "rails_helper"

describe CharacterScope do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character) }

  describe "#token_expired?" do
    context "when expired" do
      subject { build(:character_scope, token_expires_at: Time.zone.now - 1.hour) }

      specify { expect(subject.token_expired?).to eq(true) }
    end

    context "when not expired" do
      subject { build(:character_scope, token_expires_at: Time.zone.now + 1.hour) }

      specify { expect(subject.token_expired?).to eq(false) }
    end
  end
end

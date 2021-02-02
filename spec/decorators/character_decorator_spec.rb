# frozen_string_literal: true

require "rails_helper"

describe CharacterDecorator do
  xdescribe "#security_status" do
    context "when security status is missing" do
      let(:character) do
        build(:character,
          security_status: nil)
      end

      subject { character.decorate }

      specify { expect(subject.security_status).to eq(nil) }
    end

    context "when security status is present" do
      let(:character) do
        build(:character,
          security_status: 1.1234)
      end

      subject { character.decorate }

      specify { expect(subject.security_status).to eq("1.1") }
    end
  end

  xdescribe "#wallet" do
    let(:character) do
      build(:character,
        wallet: 8252.49)
    end

    subject { character.decorate }

    specify { expect(subject.wallet).to eq(8252) }
  end
end

# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprintDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#bpo?" do
    context "when blueprint is original" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -1) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpo?).to eq(true) }
    end

    context "when blueprint is copy" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -2) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpo?).to eq(false) }
    end
  end

  describe "#bpc?" do
    context "when blueprint is original" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -1) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpc?).to eq(false) }
    end

    context "when blueprint is copy" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -2) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpc?).to eq(true) }
    end
  end
end

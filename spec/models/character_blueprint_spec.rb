# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprint do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { should belong_to(:character) }

  it { should belong_to(:blueprint).class_name("Eve::Blueprint").with_primary_key("type_id").with_foreign_key("type_id").optional(true) }

  describe "#bpo?" do
    context "when blueprint is original" do
      subject { build(:character_blueprint, quantity: -1) }

      specify { expect(subject.bpo?).to eq(true) }
    end

    context "when blueprint is copy" do
      subject { build(:character_blueprint, quantity: -2) }

      specify { expect(subject.bpo?).to eq(false) }
    end
  end

  describe "#bpc?" do
    context "when blueprint is original" do
      subject { build(:character_blueprint, quantity: -1) }

      specify { expect(subject.bpc?).to eq(false) }
    end

    context "when blueprint is copy" do
      subject { build(:character_blueprint, quantity: -2) }

      specify { expect(subject.bpc?).to eq(true) }
    end
  end

  describe "#stacked?" do
    context "when stacked" do
      subject { build(:character_blueprint, quantity: 10) }

      specify { expect(subject.stacked?).to eq(true) }
    end

    context "when not stacked" do
      subject { build(:character_blueprint, quantity: -1) }

      specify { expect(subject.stacked?).to eq(false) }
    end
  end
end

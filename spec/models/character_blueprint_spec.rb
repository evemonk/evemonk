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

  describe "#material_efficiency_formatted" do
    context "when stacked" do
      subject do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      specify { expect(subject.material_efficiency_formatted).to eq(nil) }
    end

    context "when material efficiency is zero" do
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          material_efficiency: 0)
      end

      specify { expect(subject.material_efficiency_formatted).to eq("0 %") }
    end

    context "when material efficiency is more than zero" do
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          material_efficiency: 10)
      end

      specify { expect(subject.material_efficiency_formatted).to eq("+10 %") }
    end
  end

  describe "#time_efficiency_formatted" do
    context "when stacked" do
      subject do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      specify { expect(subject.time_efficiency_formatted).to eq(nil) }
    end

    context "when time efficiency is zero" do
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          time_efficiency: 0)
      end

      specify { expect(subject.time_efficiency_formatted).to eq("0 %") }
    end

    context "when time efficiency is more than zero" do
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          time_efficiency: 10)
      end

      specify { expect(subject.time_efficiency_formatted).to eq("+10 %") }
    end
  end
end

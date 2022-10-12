# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprint do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { should be_a(Imageable) }

  it { expect(described_class::RELIC_CATEGORY_ID).to eq(34) }

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

  describe "#relic?" do
    context "when relic" do
      let!(:eve_group) do
        create(:eve_group,
          group_id: 111,
          category_id: described_class::RELIC_CATEGORY_ID)
      end

      let!(:eve_type) do
        create(:eve_type,
          type_id: 123,
          group_id: 111,
          is_blueprint: true)
      end

      let!(:character_blueprint) do
        create(:character_blueprint,
          type_id: 123)
      end

      subject { character_blueprint.reload }

      specify { expect(subject.relic?).to eq(true) }
    end

    context "when not relic" do
      let!(:eve_group) do
        create(:eve_group,
          group_id: 222,
          category_id: 999)
      end

      let!(:eve_type) do
        create(:eve_type,
          type_id: 234,
          group_id: 222,
          is_blueprint: true)
      end

      let!(:character_blueprint) do
        create(:character_blueprint,
          type_id: 234)
      end

      subject { character_blueprint.reload }

      specify { expect(subject.relic?).to eq(false) }
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

  describe "#icon_tiny" do
    context "when relic" do
      before { expect(subject).to receive(:relic?).and_return(true) }

      before { expect(subject).to receive(:types_relic_url).with(32) }

      specify { expect { subject.icon_tiny }.not_to raise_error }
    end

    context "when stacked" do
      before { expect(subject).to receive(:relic?).and_return(false) }

      before { expect(subject).to receive(:stacked?).and_return(true) }

      before { expect(subject).to receive(:types_bp_url).with(32) }

      specify { expect { subject.icon_tiny }.not_to raise_error }
    end

    context "when blueprint is original" do
      before { expect(subject).to receive(:relic?).and_return(false) }

      before { expect(subject).to receive(:stacked?).and_return(false) }

      before { expect(subject).to receive(:bpo?).and_return(true) }

      before { expect(subject).to receive(:types_bp_url).with(32) }

      specify { expect { subject.icon_tiny }.not_to raise_error }
    end

    context "when blueprint is copy" do
      before { expect(subject).to receive(:relic?).and_return(false) }

      before { expect(subject).to receive(:stacked?).and_return(false) }

      before { expect(subject).to receive(:bpo?).and_return(false) }

      before { expect(subject).to receive(:bpc?).and_return(true) }

      before { expect(subject).to receive(:types_bpc_url).with(32) }

      specify { expect { subject.icon_tiny }.not_to raise_error }
    end

    context "when unknown state" do
      before { expect(subject).to receive(:relic?).and_return(false) }

      before { expect(subject).to receive(:stacked?).and_return(false) }

      before { expect(subject).to receive(:bpo?).and_return(false) }

      before { expect(subject).to receive(:bpc?).and_return(false) }

      specify { expect(subject.icon_tiny).to eq(nil) }
    end
  end

  describe "#icon_small" do
    context "when relic" do
      before { expect(subject).to receive(:relic?).and_return(true) }

      before { expect(subject).to receive(:types_relic_url).with(64) }

      specify { expect { subject.icon_small }.not_to raise_error }
    end

    context "when stacked" do
      before { expect(subject).to receive(:relic?).and_return(false) }

      before { expect(subject).to receive(:stacked?).and_return(true) }

      before { expect(subject).to receive(:types_bp_url).with(64) }

      specify { expect { subject.icon_small }.not_to raise_error }
    end

    context "when blueprint is original" do
      before { expect(subject).to receive(:relic?).and_return(false) }

      before { expect(subject).to receive(:stacked?).and_return(false) }

      before { expect(subject).to receive(:bpo?).and_return(true) }

      before { expect(subject).to receive(:types_bp_url).with(64) }

      specify { expect { subject.icon_small }.not_to raise_error }
    end

    context "when blueprint is copy" do
      before { expect(subject).to receive(:relic?).and_return(false) }

      before { expect(subject).to receive(:stacked?).and_return(false) }

      before { expect(subject).to receive(:bpo?).and_return(false) }

      before { expect(subject).to receive(:bpc?).and_return(true) }

      before { expect(subject).to receive(:types_bpc_url).with(64) }

      specify { expect { subject.icon_small }.not_to raise_error }
    end

    context "when unknown state" do
      before { expect(subject).to receive(:relic?).and_return(false) }

      before { expect(subject).to receive(:stacked?).and_return(false) }

      before { expect(subject).to receive(:bpo?).and_return(false) }

      before { expect(subject).to receive(:bpc?).and_return(false) }

      before { expect(subject).not_to receive(:types_bpc_url) }

      specify { expect(subject.icon_small).to eq(nil) }
    end
  end

  # private methods

  describe "#types_relic_url" do
    subject { build(:character_blueprint, type_id: 804) }

    before do
      #
      # imageable_url("types", type_id, "relic", size)
      #
      expect(subject).to receive(:imageable_url).with("types", 804, "relic", 64)
    end

    specify { expect { subject.send(:types_relic_url, 64) }.not_to raise_error }
  end

  describe "#types_bp_url" do
    subject { build(:character_blueprint, type_id: 804) }

    before do
      #
      # imageable_url("types", type_id, "bp", size)
      #
      expect(subject).to receive(:imageable_url).with("types", 804, "bp", 64)
    end

    specify { expect { subject.send(:types_bp_url, 64) }.not_to raise_error }
  end

  describe "#types_bpc_url" do
    subject { build(:character_blueprint, type_id: 804) }

    before do
      #
      # imageable_url("types", type_id, "bpc", size)
      #
      expect(subject).to receive(:imageable_url).with("types", 804, "bpc", 64)
    end

    specify { expect { subject.send(:types_bpc_url, 64) }.not_to raise_error }
  end
end
